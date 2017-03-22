class StageToProcess(object):
    def __init__(self, table_id, stage_begin, stage_end):
        self.table_id = table_id
        self.stage_begin = stage_begin
        self.stage_end = stage_end