# -*- coding: utf-8 -*-:
from common.db.db_config import session as sess
from common.dao.mr_task import TaskQueue, MRTask, TaskHistory
from common.entity.active_task import ActiveTask
from common.util import util
from common.util.logger import Logger

class TaskQueueScan(object):
    def __init__(self):
        self.logger = Logger(self.__class__.__name__).get()
        pass

    def dequeue_task(self):
        sq = sess.query(TaskQueue).order_by(TaskQueue.id).filter(TaskQueue.has_processed == 0)
        task = sq.first()
        res = None
        if task:
            sq2 = sess.query(MRTask).filter(MRTask.id == task.mr_task_id)
            mr_task = sq2.first()
            atask = ActiveTask(mr_task)
            atask.table_stage_list = task.table_stage_list
            atask.begin_time = util.getCurrentDatetime()
            res = (atask, task.id)
        else:
            res = (None,None)
        sess.commit()
        sess.flush()
        return res

    def set_task_processed(self, queued_id):
        queued_task = sess.query(TaskQueue).get(queued_id)
        if queued_task:
            queued_task.has_processed = 1
            queued_task.end_time = util.getCurrentDatetime().replace(tzinfo=None)
            sess.commit()
            sess.flush()
        else:
            raise ValueError("Can not find the queued_id(" + queued_id + ") from task queue")

    def move_task_to_history(self, atask):
        stage_info = atask.get_stage_info()
        th = TaskHistory(mr_task_id = atask.id, table_stage_info = stage_info, create_time = atask.create_time,
                         begin_time = atask.begin_time, end_time = atask.end_time)
        sess.add(th)
        sess.commit()
        sess.flush()
        return th


    def delete_queued_task(self, queued_id):
        self.logger.info("delete_queued_task: delete task from queue(queued_id = %s)" % queued_id)
        tq = sess.query(TaskQueue).get(queued_id)
        sess.delete(tq)
        sess.commit()
        sess.flush()

