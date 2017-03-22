class ActiveTask(object):
    def __init__(self, mr_task=None):
        self.id = mr_task.id
        self.name = mr_task.name
        self.information = mr_task.information
        self.bin_file_uri = mr_task.bin_file_uri
        self.type = mr_task.type
        self.export_dir_uri = mr_task.export_dir_uri
        self.priority = mr_task.priority
        self.table_stage_list = mr_task.table_stage_list
        self.triggle_cond_list = mr_task.triggle_cond_list

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
