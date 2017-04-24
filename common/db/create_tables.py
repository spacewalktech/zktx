# -*- coding: utf-8 -*-:
from common.db.db_config import Base
from common.db.db_config import engine
from common.dao.mr_task import MRTask # unsed import for table create
from common.dao.import_tables import Stage # unsed import for table create
from common.dao.mr_task import TaskQueue # unsed import for table create
from common.dao.import_tables import ImportTable
from common.dao.table_schema import TableSchema

if __name__ == "__main__":
    Base.metadata.create_all(engine)