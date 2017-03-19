from common.db.db_config import Base
from common.db.db_config import engine
from common.dao.mr_task import MRTask # unsed import for table create
from common.dao.stage import Stage # unsed import for table create
from common.dao.task_queue import TaskQueue # unsed import for table create

if __name__ == "__main__":
    Base.metadata.create_all(engine)