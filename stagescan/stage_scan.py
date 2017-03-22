from sqlalchemy import desc

from common.dao.mr_task import MRTask
from common.dao.stage import Stage
from common.dao.task_queue import TaskQueue
from common.db.db_config import session as sess
from common.util import util
from common.entity.active_task import ActiveTask


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

    def _get_mr_tasks(self):
        mr_task_list = []  # MRTask list
        sq = sess.query(MRTask)
        for s in sq:
            mr_task_list.append(s)

    def _get_rindex_task_map(self, mr_task_list):
        # Get map {TriggleCond: (mr_task set)}
        cond_task_map = {}
        for task in mr_task_list:
            for cond in task.triggle_cond_list:
                if cond not in cond_task_map:
                    cond_task_map[cond] = set()
                    cond_task_map[cond].add(ActiveTask(task))
                else:
                    cond_task_map[cond].add(ActiveTask(task))
        return cond_task_map


    # Get triggled tasks
    def _get_updated_active_tasks(self):
        stages = self._get_lastest_stages()
        mr_tasks = self._get_mr_tasks()
        cond_task_map = self._get_rindex_task_map(mr_tasks) # {TriggleCond: [mr_active_tasks]}
        active_tasks = []
        # For latest stages
        for stage in stages:
            if stage.triggle_cond in cond_task_map:
                triggled_tasks = cond_task_map[stage.triggle_cond] # active task list
                length = len(triggled_tasks)
                for idx in range(length):
                    self._update_atask_for_stage(triggled_tasks[idx]) # Update the task_list
                active_tasks.extend(triggled_tasks)
        return active_tasks

    def _merge_tasks_base_id(self, active_tasks):
        pass




    def _update_atask_for_stage(self, atask, stage):
        # From begin stage table_stage_list is empty for atask
        length = len(atask.table_stage_list)
        already_in = False
        for idx in range(length):
            if atask.table_stage_list[idx].table_id == stage.import_table_id:
                already_in = True
                if atask.table_stage_list[idx].stage_begin > stage.stage_id:
                    atask.table_stage_list[idx].stage_begin = stage.stage_id
                elif atask.table_stage_list[idx].stage_end < stage.stage_id:
                    atask.table_stage_list[idx].stage_end = stage.stage_id
                break # For specific task one stage can only lead one table's  stage attributes chaged
        if not already_in:
            stp = StageToProcess(stage.import_table_id, stage.stage_id, stage.stage_id)
            atask.table_stage_list.append(stp)


    def _update_task_dict(self, task_stage_dict, task, stage):
        # stage triggle the task
        if task not in task_stage_dict:
            stp = StageToProcess()
            task_stage_dict[task] = stp
            stp.table_id = stage.import_table_id
            stp.stage_begin = stage.stage_id
            stp.stage_end = stage.stage_id
        else:
            for idx in range(task_stage_dict[task]):
                if task_stage_dict[task][idx].stage_begin > stage.stage_id:
                    task_stage_dict[task][idx].stage_begin = stage.stage_id
                elif task_stage_dict[task][idx].stage_end < stage.stage_id:
                    task_stage_dict[task][idx].stage_end = stage.stage_id


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

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash((self.table_id, self.import_type))

class StageToProcess(object):
    def __init__(self, table_id, stage_begin, stage_end):
        self.table_id = table_id
        self.stage_begin = stage_begin
        self.stage_end = stage_end
