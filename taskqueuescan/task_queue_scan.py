# -*- coding: utf-8 -*-:
from common.db.db_config import session as sess
from common.dao.mr_task import TaskQueue, MRTask, TaskHistory
from common.entity.active_task import ActiveTask
from common.util import util
import common.db.db_config as db

class TaskQueueScan(object):
    def __init__(self):
        pass

    def dequeue_task(self):
        sq = sess.query(TaskQueue).order_by(TaskQueue.id).filter(TaskQueue.has_processed == 0)
        task = sq.first()
        if task:
            sq2 = sess.query(MRTask).filter(MRTask.id == task.mr_task_id)
            mr_task = sq2.first()
            atask = ActiveTask(mr_task)
            atask.table_stage_list = task.table_stage_list
            task.begin_time = util.getCurrentDatetime()
            sess.commit()
            sess.flush()
            return atask
        else:
            return None

    def set_task_processed(self, task_id):
        sq = sess.query(TaskQueue).filter(TaskQueue.mr_task_id == task_id)
        queued_task = sq.one()
        if queued_task:
            queued_task.has_processed = 1
            queued_task.end_time = util.getCurrentDatetime()
            sess.commit()
            sess.flush()
        else:
            raise ValueError("Can not find the task_id(" + task_id + ") from task queue")

    def move_task_to_history(self, atask, r):
        stage_info = atask.get_stage_info()
        th = TaskHistory(mr_task_id = atask.id, table_stage_info = stage_info, create_time = atask.create_time,
                         begin_time = atask.begin_time, end_time = atask.end_time, result_status = r)
        sess.add(th)
        sess.commit()
        sess.flush()


    def delete_queued_task(self, queued_id):
        tq = sess.query(TaskQueue).get(queued_id)
        sess.delete(tq)
        sess.commit()
        sess.flush()

    def submit_task(self, atask):
        pass
