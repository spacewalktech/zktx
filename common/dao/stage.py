# -*- coding: utf-8 -*-：

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column
from sqlalchemy.dialects.mysql import INTEGER, DATETIME, TEXT, TINYINT
from sqlalchemy.schema import ForeignKey
from common.db.db_config import Base

'''
CREATE TABLE `tb_stage` (
`id` int(11) NOT NULL,
`import_table_id` int(11) NULL COMMENT '导入表id',
`import_type` tinyint(1) NULL COMMENT '导入类型，0(full)或者1(incremental)'
`stage_id` int(11) NULL COMMENT '每个stage对导入表产生一个stage_id,每次加1',
`inserted_num` int(11) NULL COMMENT '增加的记录数',
`updated_num` int(11) NULL COMMENT '更新的记录数',
`deleted_num` int(11) NULL,
`record_num` int(11) NULL,
`status` tinyint(1) NULL COMMENT '最近导入、处理是否成功 0 成功 1.失败',
`create_time` datetime NULL COMMENT '创建时间',
`update_time` datetime NULL COMMENT '更新时间',
`begin_time` datetime NULL COMMENT '开始执行时间',
`end_time` datetime NULL COMMENT '执行结束时间',
`process_status` int(11) NULL COMMNET '是否trigger了mr_task中的任务，0还没有被处理，1处理了没有triggle task，2处理了也triggle task了',
PRIMARY KEY (`id`) ,
CONSTRAINT `fk_db_stage` FOREIGN KEY (`import_table_id`) REFERENCES `tb_import_tables` (`id`)
);
'''

# tb_task_queue table
class Stage(Base):
    __tablename__ = "tb_stage"

    id = Column('id', INTEGER(11), primary_key=True)
    # import_table_id = Column('import_table_id', INTEGER(11), ForeignKey("tb_import_tables.import_table_id"))
    import_table_id = Column('import_table_id', INTEGER(11))
    import_type = Column('import_type', TINYINT(1))
    stage_id = Column('stage_id', INTEGER(11))
    inserted_num = Column('inserted_num', INTEGER(11))
    updated_num = Column('updated_num', INTEGER(11))
    deleted_num = Column('deleted_num', INTEGER(11))
    record_num = Column('record_num', INTEGER(11))
    status = Column('status', TINYINT(1))
    fail_info = Column("fail_info" , TEXT)
    create_time = Column('create_time', DATETIME())
    update_time = Column('update_time', DATETIME())
    begin_time = Column('begin_time', DATETIME())
    end_time = Column('end_time', DATETIME())
    process_status = Column('process_status', TINYINT(1))

    def __eq__(self, other):
        return self.id == other.id