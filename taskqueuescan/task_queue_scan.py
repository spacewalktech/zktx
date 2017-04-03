# -*- coding: utf-8 -*-：
from common.db.db_config import session as sess
from common.dao.mr_task import TaskQueue
from common.entity.active_task import ActiveTask

class TaskQueueScan(object):
    def __init__(self):
        pass

    def dequeue_task(self):
        sq = sess.query(TaskQueue).order_by(TaskQueue.id).filter(TaskQueue.has_processed == 0)
        task = sq.first()
        if task:
            atask = ActiveTask()
            atask.id = task.mr_task_id
            atask.table_stage_list = task.table_stage_list
            return atask
        else:
            return None

    def set_task_processed(self, task_id):
        sq = sess.query(TaskQueue).filter(TaskQueue.mr_task_id == task_id)
        queued_task = sq.one()
        if queued_task:
            queued_task.has_processed = 1
            sess.commit()
            sess.flush()
        else:
            raise ValueError("Can not find the task_id(" + task_id + ") from task queue")
