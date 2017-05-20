# -*- coding: utf-8 -*-:
from sqlalchemy import desc
from common.dao.mr_task import MRTask
from common.dao.import_tables import Stage
from common.dao.mr_task import TaskQueue
from common.db.db_config import session as sess
from common.entity.active_task import ActiveTask
from common.entity.stage_to_process import StageToProcess
from common.util import util
from common.util.logger import Logger

class StageScan(object):

    def __init__(self):
        self.logger = Logger(self.__class__.__name__).get()
        self.stages = None

    def _get_lastest_stages(self):
        self.logger.info("Begin to execute _get_latest_stages")
        stages = []
        # Get not-processed stages
        sq = sess.query(Stage).order_by(Stage.id).filter(Stage.process_status == 0)
        for s in sq:
            stages.append(s)
        # Get normal ordered stages
        self.logger.info("Success to execute _get_latest_stages")
        # return stages[::-1]
        return stages

    def _get_mr_tasks(self):
        self.logger.info("Begin to execute _get_mr_tasks")
        mr_task_list = []  # MRTask list
        sq = sess.query(MRTask).filter(MRTask.type < 2)
        for s in sq:
            mr_task_list.append(s)
        self.logger.info("Success to execute _get_mr_tasks")
        return mr_task_list

    def _convert_mr_task_to_atask_dict(self, mr_task_list):
        mr_task_dict = {}
        for mr_task in mr_task_list:
            atask = ActiveTask(mr_task)
            mr_task_dict[mr_task.id] = atask
        return mr_task_list

    def _get_task_queue(self):
        self.logger.info("Begin to execute _get_task_queue")
        task_queue_list = []
        sq = sess.query(TaskQueue).filter(TaskQueue.has_processed == 0)
        for s in sq:
            task_queue_list.append(s)
        self.logger.info("Success to execute _get_task_queue")
        return task_queue_list

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
        # Convert set to list
        for cond in cond_task_map:
            cond_task_map[cond] = list(cond_task_map[cond])
        return cond_task_map

    # Get triggled tasks
    def _get_staged_active_tasks(self):
        self.stages = self._get_lastest_stages()
        stages = self.stages
        mr_tasks = self._get_mr_tasks()
        cond_task_map = self._get_rindex_task_map(mr_tasks) # {TriggleCond: [mr_active_tasks]}
        active_tasks = []
        # For latest stages
        for stage in stages:
            if stage.triggle_cond in cond_task_map:
                triggled_tasks = cond_task_map[stage.triggle_cond] # active task list
                length = len(triggled_tasks)
                for idx in range(length):
                    self._update_atask_for_stage(triggled_tasks[idx], stage) # Update the task_list
                #active_tasks.extend(triggled_tasks)
        for cond in cond_task_map:
            active_tasks.extend(cond_task_map[cond])
        return active_tasks # Contains all active tasks triggled

    def _update_atask_for_stage(self, atask, stage):
        # From begin stage table_stage_list is empty for atask
        self.logger.debug("_update_atask_for_stage: Before update, atask is ActiveTask(%s), stage_id is: \
            (table_id=%s, stage_id=%s)" % (atask, stage.import_table_id, stage.stage_id))
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
        self.logger.debug("_update_atask_for_stage: After update, atask is ActiveTask(%s)" % atask)

    def _get_queued_active_task(self):
        queued_tasks = self._get_task_queue()
        mr_task_list = self._get_mr_tasks()
        atask_dict = self._convert_mr_task_to_atask_dict(mr_task_list)
        active_tasks = []
        for qtask in queued_tasks:
            if qtask.mr_task_id in atask_dict:
                atask = atask_dict[qtask.mr_task_id]
                atask.table_stage_list = qtask.table_stage_list
                active_tasks.append(atask)
        return active_tasks

    # merge staged task to queue task
    def _merge_atask_staged_to_queued(self):
        staged_active_tasks = self._get_staged_active_tasks()
        self.logger.debug("_merge_atask_staged_to_queued: Before, staged_active_tasks(%s)" %
                          util.object_list_to_str(staged_active_tasks))
        queued_active_tasks = self._get_queued_active_task()
        self.logger.debug("_merge_atask_staged_to_queued: Before, queued_active_tasks(%s)" %
                          util.object_list_to_str(queued_active_tasks))
        atask_dict = {} # task_id: active_task
        for atask in queued_active_tasks:
            atask_dict[atask.id] = atask
        for sa_task in staged_active_tasks:
            if sa_task.id not in atask_dict:
                atask_dict[sa_task.id] = sa_task
            else:
                atask_dict[sa_task.id].table_stage_list = self._merge_staged_tasks_queued(sa_task, atask_dict[sa_task.id])
        new_task_list = []
        for task_id in atask_dict:
            new_task_list.append(atask_dict[task_id])
        self.logger.debug("_merge_atask_staged_to_queued: After, new_task_list(%s)" %
                          util.object_list_to_str(new_task_list))
        return new_task_list

    # merge the same task in staged and queued
    def _merge_staged_tasks_queued(self, staged_atask, queued_atask):
        self.logger.debug("_merge_staged_tasks_queued(staged_atask=%s, queued_atask=%s)" %
              (staged_atask, queued_atask))
        staged_stps = staged_atask.table_stage_list
        queued_stps = queued_atask.table_stage_list
        queued_stp_dict = {} # table_id: stp_list
        for stp in queued_stps:
            queued_stp_dict[stp.table_id] = stp
        for stp in staged_stps:
            if stp.table_id in queued_stp_dict:
                # update stage_begin
                if queued_stp_dict[stp.table_id].stage_begin > stp.stage_begin:
                    queued_stp_dict[stp.table_id].stage_begin = stp.stage_begin
                # update stage_end
                if queued_stp_dict[stp.table_id].stage_end < stp.stage_end:
                    queued_stp_dict[stp.table_id].stage_end = stp.stage_end
            else:
                queued_stp_dict[stp.table_id] = stp
        new_stp_list = []
        for table_id in queued_stp_dict:
            new_stp_list.append(queued_stp_dict[table_id])
        return new_stp_list

    def update_queue_tb(self):
        new_queued_tasks = self._merge_atask_staged_to_queued()
        # Get task from tb_task_queue
        for active_task in new_queued_tasks:
            self.logger.info("Begin to update task(id=%s) in tb_task_queue" % active_task.id)
            # sq = sess.query(TaskQueue).filter(TaskQueue.mr_task_id == active_task.id, TaskQueue.has_processed == 0)
            # queued_task = sq.first()
            if active_task.table_stage_list:
                self.logger.debug("Insert ActiveTask(%s) to queue" % active_task)
                encoded_table_stage = util.encode_table_stage(active_task.table_stage_list)
                tq = TaskQueue(mr_task_id = active_task.id, table_stage_info=encoded_table_stage)
                tq.create_time = util.getCurrentDatetime()
                sess.add(tq)
		    # queued_task.has_processed = 0
        sess.commit()
        sess.flush()
        self._update_stage_to_processed()

    def _update_stage_to_processed(self):
        self.logger.info("Begin to _update_stage_to_processed")
        # Get not-processed stages from the bottom of the table
        sq = sess.query(Stage).order_by(desc(Stage.id)).filter(Stage.process_status == 0)
        processed_stages = set()
        for stage in self.stages:
            processed_stages.add(stage.id)
        for s in sq:
            if s.id in processed_stages:
                self.logger.debug("Updating stage(stage_id=%s)" % s.id)
                s.process_status = 1
        sess.commit()
        sess.flush()

    def enqueue_time_task(self):
        self.logger.info("Begin to enque_time_task")
        sq_task = sess.query(MRTask).filter(MRTask.type > 1)
        for s in sq_task:
            #sq2_queue = sess.query(TaskQueue).filter(TaskQueue.mr_task_id == s.id)
            #qtask = sq2_queue.first()
            # time task not in task queue, we should enqueue the task
            if s.time_to_process():
                tq = TaskQueue(mr_task_id = s.id)
                tq.create_time = util.getCurrentDatetime().replace(tzinfo=None)
                #s.update_time == tq.create_time
                tq.has_processed = 0
                sess.add(tq)
        sess.commit()
        sess.flush()

