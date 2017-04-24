from hdfs import InsecureClient
from common.dao.mr_task import MRTask
from task.submit import Submitter
from common.entity.active_task import ActiveTask

atask = ActiveTask()
atask.id = 1
atask.bin_file_uri = "hdfs://hadoop01:9000/wenjun/test_data_context.py"
atask.export_dir_uri = "hdfs://hadoop01:9000/wenjun/test_export"
atask.type = 0
atask.has_derivative_table = False
sb = Submitter()
sb.submit(atask)