# -*- coding: utf-8 -*-:
class StageToProcess(object):
    def __init__(self, table_id, stage_begin, stage_end):
        self.table_id = table_id
        self.stage_begin = stage_begin
        self.stage_end = stage_end

    def __eq__(self, other):
        return self.table_id == other.table_id and self.stage_begin == other.stage_begin and self.stage_end == other.stage_end

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash((self.table_id, self.stage_begin, self.stage_end))

    def __str__(self):
        return "StageToProcess(table_id=%s, stage_begin=%s, stage_end=%s)" % \
               (self.table_id, self.stage_begin, self.stage_end)