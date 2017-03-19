import json
from stagescan.stage_scan import TriggleCond

def decode_triggle_tables(triggle_table_in_text):
    triggle_list = [] # [<table_id, import_type>, ...]
    triggles = json.loads(triggle_table_in_text)
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
    table_stage_dict = json.loads(stage_info) # {"table_a": [1,5],"table_b":[5,7]}
    return table_stage_dict
