# -*- coding: utf-8 -*-：
# 工具类

import sys


def get_param(param_name=None):
    if (param_name == None):
        return None
    param_name = str.strip(param_name)
    argv = sys.argv

    for index, item in enumerate(argv):
        item = str.strip(item)
        if (param_name == item):
            return argv[index + 1]
