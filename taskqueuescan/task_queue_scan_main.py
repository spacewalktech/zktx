# -*- coding: utf-8 -*-:
import time
from common.util import util
from taskqueuescan.task_queue_scan import TaskQueueScan
from common.config.config import task_queue_scan_interval
from common.util.logger import Logger
from task.submit import Submitter

logger = Logger("taskqueue_scan_main.py").get()
def process_task(active_task):
    # print(active_task)
    logger.info("Begin to submit ActiveTask(%s)" % active_task)
    sb = Submitter()
    result = sb.submit(active_task)
    return result



if __name__ == "__main__":
    while True:
        tqc = TaskQueueScan()
        atask = tqc.dequeue_task()
        if atask:
            if atask.should_process():
                atask.begin_time = util.getCurrentDatetime()
                r = process_task(atask)
                atask.end_time = util.getCurrentDatetime()
                tqc.move_task_to_history(atask, r)
                if atask.type != 2:
                    tqc.set_task_processed(atask.id)
                    tqc.delete_task(atask.id)

        time.sleep(task_queue_scan_interval)
