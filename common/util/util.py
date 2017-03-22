import json
from common.entity.triggle_cond import TriggleCond
from common.entity.stage_to_process import StageToProcess

def decode_triggle_conds(triggle_cond_in_text):
    triggle_list = [] # [<table_id, import_type>, ...]
    triggles = json.loads(triggle_cond_in_text)
    for triggle_dict in triggles:
        triggle_obj = TriggleCond()
        triggle_obj.table_id = triggle_dict["table"]
        if triggle_dict["type"].lower() == "full":
            triggle_obj.import_type = 0
        elif triggle_dict["type"].lower() == "incremental":
            triggle_obj.import_type = 1
        else:
            raise ValueError("Invalid import type: " + triggle_dict["type"])
        triggle_list.append(triggle_obj)
    return triggle_list

def decode_table_stage_info(stage_info):
    # return stage info list [<table, stage_begin, stage_end>]
    table_stage_dict = json.loads(stage_info) # {"table_a": [1,5],"table_b":[5,7]}
    stage_info_list = []
    for tab in table_stage_dict:
        stage_info = StageToProcess()
        stage_info.table_id = tab
        stage_info.stage_begin = table_stage_dict[tab][0]
        stage_info.stage_end = table_stage_dict[tab][1]
        stage_info_list.append(stage_info)
    return stage_info_list
