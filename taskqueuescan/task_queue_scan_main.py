# -*- coding: utf-8 -*-:
import time
from common.util import util
from taskqueuescan.task_queue_scan import TaskQueueScan
from common.config.config import task_queue_scan_interval

if __name__ == "__main__":
    while True:
        tqc = TaskQueueScan()
        atask, queued_id = tqc.dequeue_task()
        if atask:
            atask.begin_time = util.getCurrentDatetime()
            task_history = tqc.move_task_to_history(atask)
            tqc.process_task(atask, task_history)
            atask.end_time = util.getCurrentDatetime()
            #tqc.move_task_to_history(atask, r)
            #tqc.set_task_processed(queued_id)
            tqc.delete_queued_task(queued_id)

        time.sleep(task_queue_scan_interval)
