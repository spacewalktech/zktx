from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column
from sqlalchemy.dialects.mysql import INTEGER, DATETIME, TEXT, TINYINT
from sqlalchemy.schema import ForeignKey
from common.db.db_config import Base

'''
CREATE TABLE `tb_task_queue` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`mr_task_id` int(11) NULL,
`table_stage_info` text NULL,
`create_time` datetime NULL COMMENT ' 创建时间',
`update_time` datetime NULL COMMENT '更新时间',
`begin_time` datetime NULL,
`end_time` datetime NULL,
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

    def __eq__(self, other):
        return self.id == other.id