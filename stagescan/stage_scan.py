from common.db.db_config import session as sess
from common.dao.stage import Stage
from common.dao.mr_task import MRTask
from common.dao.task_queue import TaskQueue
from sqlalchemy import desc
from stagescan import util
import datetime

class StageScan(object):

    def __init__(self):
        pass

    def _get_lastest_stages(self):
        stages = []
        # Get not-processed stages from the bottom of the table
        sq = sess.query(Stage).order_by(desc(Stage.id)).filter_by(Stage.process_status==0)
        for s in sq:
            stages.append(s)
        # Get normal ordered stages
        return reversed(stages)

    # Get all mr_tasks registered by user, reverse indexed by triggle table_id
    def _get_mr_tasks(self):
        mr_task_map = {} # {table_id: tasks}
        mr_task_list = [] # tasks list map to the tb_mr_task table
        sq = sess.query(MRTask)
        for s in sq:
            mr_task_list.append(s)
            triggle_list = util.decode_triggle_tables(s.triggle_tables)
            s.triggle_list = triggle_list
            for ts in triggle_list:
                if not ts.table_id in mr_task_map:
                    task_set = set()
                    task_set.add(s)
                    mr_task_map[ts.table_id] = task_set
                else:
                    mr_task_map[ts.table_id].add(s)
        return mr_task_map, mr_task_list

    # Get triggled tasks
    def scan_stage(self):
        # [task_queue1, task_queue2...]
        triggled_tasks = []
        stages = self._get_lastest_stages()
        mr_task_map = self._get_mr_tasks()
        # For latest stages
        for stage in stages:
            # task_map indexed by import_table_id
            if stage.import_table_id in mr_task_map:
                tasks = mr_task_map[stage.import_table_id]
                # For current table in stage mapped tasks
                for task in tasks:
                    # Get triggle list for the task
                    for triggle_cond in task.triggle_list:
                        # If we should triggle the task, If any condition matched in the list, we should triggle the task
                        if (stage.import_table_id == triggle_cond.table_id) and (stage.import_type == triggle_cond.import_type):
                            tq = TaskQueue()
                            tq.mr_task_id = task.id
                            tq.table_id = stage.import_table_id
                            tq.stage_id = stage.stage_id
                            triggled_tasks.append(tq)
        return triggled_tasks

    # task_queue_list item is [<table_id, stage_id, task_id>]
    # we want to get {task_id: {table_id: [stage_id_begin, stage_id_end], ...}, ...}
    def merge_task(self, task_queue_list):
        merge_dict = {} # {task_id: {table_id: (stage_id_begin, ..., stage_id_end), ...}, ...}
        for task_queue in task_queue_list:
            if task_queue.table_id not in merge_dict:
                merge_dict[task_queue.id] = {}
                merge_dict[task_queue.id][task_queue.table_id] = [task_queue.stage_id]
            else:
                if task_queue.table_id not in merge_dict[task_queue.id]:
                    merge_dict[task_queue.id][task_queue.table_id] = [task_queue.stage_id]
                else:
                    merge_dict[task_queue.id][task_queue.table_id].append(task_queue.stage_id)
        for task_id in merge_dict:
            table_dict = merge_dict[task_id]
            for table_id in table_dict:
                stage_list = table_dict[table_id]
                sorted_list = sorted(stage_list)
                beg_stage = sorted_list[0]
                end_stage = sorted_list[-1]
                merge_dict[task_id][table_id] = [beg_stage, end_stage]
        return merge_dict

    # Get unprocessed tasks from tb_task_queue
    # We want to get {task_id: {table_id: [stage_id_begin, stage_id_end], ...}, ...}
    def _get_unprocessed_queue(self):
        table_stage_dict = {}
        sq = sess.query(TaskQueue).filter_by(TaskQueue.has_processed==0)
        for s in sq:
            table_stage = util.decode_table_stage_info(s.table_stage_info)
            task_id = s.mr_task_id
            table_stage_dict[task_id] = table_stage
        return table_stage_dict



class TriggleCond(object):
    def __init__(self, table_id, import_type):
        self.table_id = table_id
        self.import_type = import_type

    def __eq__(self, other):
        return self.table_id == other.table_id and self.import_type == other.import_type

class StageToProcess(object):
    def __init__(self, table_id, stage_begin, stage_end):
        self.table_id = table_id
        self.stage_begin = stage_begin
        self.stage_end = stage_end