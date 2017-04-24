# -*- coding: utf-8 -*-:
import time
from stagescan.stage_scan import StageScan
from common.config.config import stage_scan_interval

if __name__ == "__main__":
    sc = StageScan()
    while True:
        sc.update_queue_tb()
        time.sleep(stage_scan_interval)

