# -*- coding: utf-8 -*-:
from taskqueuescan.task_queue_scan import TaskQueueScan
from common.config.config import task_queue_scan_interval
from common.util.logger import Logger
from task.submit import Submitter
import time

logger = Logger("taskqueue_scan_main.py").get()
def process_task(active_task):
    # print(active_task)
    logger.info("Begin to submit ActiveTask(%s)" % active_task)
    sb = Submitter()
    sb.submit(active_task)


if __name__ == "__main__":
    while True:
        tqc = TaskQueueScan()
        atask = tqc.dequeue_task()
        if atask:
            process_task(atask)
            tqc.set_task_processed(atask.id)
        time.sleep(task_queue_scan_interval)
