from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column
from sqlalchemy.dialects.mysql import TINYINT, INTEGER, LONGTEXT, VARCHAR, DATETIME, TEXT
from common.db.db_config import Base
from sqlalchemy.ext.hybrid import hybrid_property, hybrid_method
from common.entity.stage_to_process import StageToProcess
from common.util import util

'''
CREATE TABLE `tb_mr_task` (
`id` int(11) NOT NULL,
`name` varchar(50) NULL COMMENT '任务名称',
`information` varchar(500) NULL COMMENT '任务说明',
`bin_file_uri` varchar(255) NULL COMMENT '运行表jar、python 文件的位置',
`type` tinyint(1) NULL COMMENT '是否是逻辑表创建任务（0：是；1：否）',
`export_dir_uri` varchar(50) NULL COMMENT ' 导出文件的位置',
`priority` int(11) NULL COMMENT '优先级',
`table_stage_info` longtext NULL COMMENT 'json，需要执行的表的stage信息{“表a”：[1,5],”表b”：[5,7]}',
`triggle_tables` longtext NULL COMMENT '触发条件：[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]',
`active` tinyint(1) NULL COMMENT '激活的（只有激活的才进行更新）（0：未激活；1：激活）',
`task_schedule` varchar(50) NULL COMMENT '定时运行 (cron表达式)',
`latest_running_time` datetime NULL COMMENT '上次运行时间',
`latest_running_status` tinyint(1) NULL COMMENT '最近运行是否成功（0：失败；1：成功）',
`latest_running_info` text NULL COMMENT '运行失败信息',
`flag` tinyint(1) NULL COMMENT '0正常；1删除',
`create_time` datetime NULL COMMENT '创建时间',
`update_time` datetime NULL COMMENT '更新时间',
PRIMARY KEY (`id`)
);
'''

# tb_mr_task table
class MRTask(Base):
    __tablename__ = "tb_mr_task"

    id = Column('id', INTEGER(11), primary_key=True)
    name = Column('name', VARCHAR(50))
    information = Column('information', VARCHAR(500))
    bin_file_uri = Column('bin_file_uri', VARCHAR(255))
    type = Column('type', TINYINT(1))
    export_dir_uri = Column('export_dir_uri', VARCHAR(50))
    priority = Column('priority', INTEGER(11))
    table_stage_info = Column('table_stage_info', LONGTEXT)
    triggle_tables = Column('triggle_tables', LONGTEXT)
    active = Column('active', TINYINT(1))
    task_schedule = Column('task_schedule', VARCHAR(50))
    latest_running_time = Column('latest_running_time', DATETIME())
    latest_running_status = Column('latest_running_status', TINYINT(1))
    latest_running_info = Column('latest_running_info', TEXT())
    flag = Column('flag', TINYINT(1))
    create_time = Column('create_time', DATETIME())
    update_time = Column('update_time', DATETIME())

    @hybrid_property
    def triggle_cond_list(self):
        # unmarsh the triggle_tables into python object
        # return TriggleCond list
        return util.decode_triggle_conds(self.triggle_tables)

    @hybrid_property
    def table_stage_list(self):
        # unmarsh the table_stage_info into python object
        # return StageToProcess list
        return util.decode_table_stage_info(self.table_stage_info)

    def __eq__(self, other):
        return self.id == other.id and \
                self.name == other.name and \
                self.information == other.information and \
                self.bin_file_uri == other.bin_file_uri and \
                self.type == other.type

    def __hash__(self):
        return hash((self.id, self.name, self.information, self.bin_file_uri, self.type))

    def __ne__(self, other):
        return not self.__eq__(other)

