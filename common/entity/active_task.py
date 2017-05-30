# -*- coding: utf-8 -*-:
import json
from common.util import util
from common.util.logger import Logger

class ActiveTask(object):
    def __init__(self, mr_task=None):
        self.logger = Logger(self.__class__.__name__).get()
        if mr_task:
            self.id = mr_task.id
            self.name = mr_task.name
            self.information = mr_task.information
            self.bin_file_uri = mr_task.bin_file_uri
            self.has_derivative_table = mr_task.has_derivative_table
            self.type = mr_task.type
            self.export_dir_uri = mr_task.export_dir_uri
            self.priority = mr_task.priority
            self.table_stage_list = mr_task.table_stage_list
            self.triggle_cond_list = mr_task.triggle_cond_list
            self.export_table_list = mr_task.export_table_list
            self.schedule_cron = mr_task.task_schedule
            self.hive_params_list = mr_task.hive_params_list
            self.create_time = mr_task.create_time
            self.begin_time = None
            self.end_time = None
            #self.db_name = mr_task.db_name
        else:
            self.id = None
            self.name = None
            self.information = None
            self.bin_file_uri = None
            self.has_derivative_table = None
            self.type = None
            self.export_dir_uri = None
            self.priority = None
            self.table_stage_list = None
            self.triggle_cond_list = None
            self.export_table_list = None
            self.schedule_cron = None
            self.hive_params_list = None
            self.create_time = None
            self.begin_time = None
            self.end_time = None
            #self.db_name = None

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

    def __str__(self):
        ret_str = "{ActiveTask(id=%s, name=%s, information=%s, bin_file_uri=%s, has_derivative_table=%s, type=%s, export_dir_uri=%s, table_stage_list=[" % \
                  (self.id, self.name, self.information, self.bin_file_uri, self.has_derivative_table, self.type, self.export_dir_uri)
        for table_stage in self.table_stage_list:
            ret_str += str(table_stage)
            ret_str += ","
        ret_str += "]}"
        return ret_str

    def should_process(self):
        if self.type < 2:
            return True
        cur_datetime = util.getCurrentDatetime()
        cur_year = cur_datetime.year
        cur_day_in_week = cur_datetime.weekday()
        cur_month = cur_datetime.month
        cur_day_in_month = cur_datetime.day
        cur_hour = cur_datetime.hour
        cur_minute = cur_datetime.minute
        self.logger.debug("task schedule_cron is: %s, current time is:{minutes(%s), hour(%s)," 
                        " day_in_month(%s), month(%s), day_in_week(%s)}" % \
                        (self.schedule_cron, cur_minute, cur_hour, cur_day_in_month, cur_month, cur_day_in_week))
        if cur_year in self.schedule_cron.years and \
            cur_day_in_week in self.schedule_cron.days_in_week and \
            cur_month in self.schedule_cron.months and \
            cur_day_in_month in self.schedule_cron.days_in_month and \
            cur_hour in self.schedule_cron.hours and \
            cur_minute in self.schedule_cron.minutes:
            return True
        return False

    def get_stage_info(self):
        return util.encode_table_stage(self.table_stage_list)
