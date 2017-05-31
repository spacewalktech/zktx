# -*- coding: utf-8 -*-：
# schema转换

import json


def get_type(o_type):
    if 'decimal' in o_type:
        return 'double'
    if 'datetime' in o_type:
        return 'timestamp'
    return 'string'


def get_string(path):
    schema = open(path)
    lines = schema.readlines(100000)
    string = ''
    for line in lines:
        string += line
    string = string.lower()
    return string


def get_cloumn(string):
    if string.startswith('create table') is False:
        string = string[string.index('create table'): len(string)]

    if ");" in string:
        string = string[0: string.index(');')]

    if '"' in string:
        string = string.replace('"', '')

    if '`' in string:
        string = string.replace('`', '')

    if 'not null' in string:
        string = string.replace('not null', '')
    m = string.index('(') + 1
    n = (string.rfind(');'))
    string = string[m:n]
    return string


def get(path):
    if path is None:
        print '--->解析建表语句问题：传入的path为空'
        return {}

    # schema = open('/Users/lzf/Desktop/data/prpcitem_car.txt')
    # schema = open('/users/lzf/desktop/prpcopyitemkind.txt')
    # schema = open('/users/lzf/desktop/prplcompensate.txt')
    # schema = open('/Users/lzf/Desktop/data/lis/llcase/full/20170401_09_37_01/schema.sql')
    # schema = open('/Users/lzf/Desktop/data/lis/LLClaim/incremental/20170404_09_37_01/schema.sql')
    # schema = open('/Users/lzf/Desktop/data/lis/LLCasePolicy/full/20170401_09_37_01/schema.sql')

    string = get_string(path)

    string = get_cloumn(string)

    string = string.splitlines(False)

    json_array_origin = []
    json_array_spark = []
    name_array = []

    pk_aray = []
    fk_aray = []

    for s in string:
        array = s.split()
        if len(array) >= 2:
            name = array[0]
            if name == 'check':
                continue
            if name == 'default':
                continue
            if name == 'primary':
                m = s.index('(') + 1
                n = s.index(')')
                o_type = s[m: n]
                print o_type
                if ',' in o_type:
                    array_o_type = o_type.split(',')
                    for i in array_o_type:
                        pk_aray.append(i.strip())
                else:
                    pk_aray.append(o_type)
            if name == 'foreign':
                m = s.index('(') + 1
                n = s.index(')')
                o_type = s[m: n]
                if ',' in o_type:
                    array_o_type = o_type.split(',')
                    for i in array_o_type:
                        fk_aray.append(i)
                else:
                    fk_aray.append(o_type)

    # print pk_aray
    # print fk_aray

    for s in string:
        array = s.split()
        if len(array) >= 2:
            dic = {}
            diu = {}
            name = array[0]
            if name == 'check':
                continue
            if name == 'default':
                continue
            if name == 'primary':
                continue
            if name == 'foreign':
                continue
            if name in pk_aray:
                dic["primary"] = 1
            if name in fk_aray:
                dic["foreign"] = 1
            o_type = array[1]
            name_array.append(name)
            dic["name"] = name
            diu["name"] = name
            dic["type"] = o_type
            json_array_origin.append(dic)
            spark_type = get_type(o_type)
            diu["type"] = spark_type
            json_array_spark.append(diu)
        else:
            print '--->解析建表语句问题：这个列有问题-->' + s + '<--'

    print json.dumps(json_array_origin)
    print json.dumps(json_array_spark)
    return {'origin_json': json.dumps(json_array_origin), 'spark_json': json.dumps(json_array_spark), 'name_array': name_array}

# print(get('/Users/lzf/Desktop/data/prpcitem_car.txt'))
get('/Users/lzf/ZKTX/安徽人保/处理/DDL_old/prpcitemkind.sql')
