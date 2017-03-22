from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column
from sqlalchemy.dialects.mysql import INTEGER, DATETIME, TEXT, TINYINT
from sqlalchemy.schema import ForeignKey
from common.db.db_config import Base
from sqlalchemy.ext.hybrid import hybrid_property, hybrid_method
from common.entity.stage_to_process import StageToProcess
from common.util import util

'''
CREATE TABLE `tb_task_queue` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`mr_task_id` int(11) NULL,
`table_stage_info` text NULL,
`create_time` datetime NULL COMMENT ' 创建时间',
`update_time` datetime NULL COMMENT '更新时间',
`begin_time` datetime NULL,
`end_time` datetime NULL,
`has_processed` tinyint(1) NULL COMMENT '在queue中是否已经被处理, 0表示没有被处理，1表示被处理了',
PRIMARY KEY (`id`) ,
CONSTRAINT `fk_db_task_queue` FOREIGN KEY (`mr_task_id`) REFERENCES `db_mr_task` (`id`)
);
'''

# tb_task_queue table
class TaskQueue(Base):
    __tablename__ = "tb_task_queue"

    id = Column('id', INTEGER(11), primary_key=True)
    mr_task_id = Column('mr_task_id', INTEGER(11), ForeignKey("tb_mr_task.id"))
    table_stage_info = Column('table_stage_info', TEXT())
    create_time = Column('create_time', DATETIME())
    update_time = Column('update_time', DATETIME())
    begin_time = Column('begin_time', DATETIME())
    end_time = Column('end_time', DATETIME())
    has_processed = Column('has_processed', TINYINT(1))

    @hybrid_property
    def table_stage_list(self):
        # unmarsh the table_stage_info into python object
        # return StageToProcess list
        return util.decode_table_stage_info(self.table_stage_info)
