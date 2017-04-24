# -*- coding: utf-8 -*-:
from taskqueuescan.task_queue_scan import TaskQueueScan
from common.config.config import task_queue_scan_interval
from task.submit import Submitter
import time

def process_task(active_task):
    # print(active_task)
    sb = Submitter(active_task)
    sb.submit()


if __name__ == "__main__":
    tqc = TaskQueueScan()
    while True:
        atask = tqc.dequeue_task()
        if atask:
            process_task(atask)
            tqc.set_task_processed(atask.id)
            time.sleep(task_queue_scan_interval)
