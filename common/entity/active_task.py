# -*- coding: utf-8 -*-:
class ActiveTask(object):
    def __init__(self, mr_task=None):
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
