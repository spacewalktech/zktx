# -*- coding: utf-8 -*-：
import json
from common.entity.triggle_cond import TriggleCond
from common.entity.stage_to_process import StageToProcess

def decode_triggle_conds(triggle_cond_in_text):
    triggle_list = [] # [<table_id, import_type>, ...]
    triggles = json.loads(triggle_cond_in_text)
    for triggle_dict in triggles:
        for table_id in triggle_dict:
            triggle_obj = TriggleCond()
            triggle_obj.table_id = int(table_id)
            triggle_obj.import_type = triggle_dict[table_id]
            triggle_list.append(triggle_obj)
    return triggle_list

def decode_table_stage_info(stage_info):
    # return stage info list [<table, stage_begin, stage_end>]
    table_stage_dict = json.loads(stage_info) # {"table_a": [1,5],"table_b":[5,7]}
    stage_info_list = []
    for tab in table_stage_dict:
        stage_info = StageToProcess(tab, table_stage_dict[tab][0], table_stage_dict[tab][1])
        stage_info_list.append(stage_info)
    return stage_info_list

def encode_table_stage(stage_info_list):
    stp_dict = {}
    for stp in stage_info_list:
        stp_dict[stp.table_id] = [stp.stage_begin, stp.stage_end]
    return json.dumps(stp_dict)

def object_list_to_str(object_list):
    ret_str = "["
    for obj in object_list:
        ret_str = "%s, %s" % (ret_str, obj)
    ret_str += "]"
    return ret_str

