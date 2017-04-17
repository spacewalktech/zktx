# -*- coding: utf-8 -*-：
# schema转换

'''
1. datetime year to second  timestamp
2. not null                 去掉
3. text                     string
4. datetime year to month   string
5. date                     string
6. foreign key              去掉
7. primary key 后面的内容都可以删掉
8. 保留索引
    create index index1_index_test on table index_test(id) AS  'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
    drop index index1_index_test on index_test
    create index index1_index_test on table index_test(id)
'''


def get_str(line_str):
    if 'not null' in line_str:
        line_str = line_str.replace(' not null', '')
    if ' text,' in line_str:
        line_str = line_str.replace(' text,', ' string,')
    if ' date,' in line_str:
        line_str = line_str.replace(' date,', ' string,--date')
    if ' datetime year to month,' in line_str:
        line_str = line_str.replace(' datetime year to month,', ' string,--date')
    if ' datetime year to second,' in line_str:
        line_str = line_str.replace(' datetime year to second,', ' string,--date')
    return line_str


def sep(string):
    count = string.rfind(',')
    temp = string[0:count]
    temp2 = string[count + 1:len(string)]
    return temp + temp2


def clean(string):
    if 'primary key' in string:
        m = string.rfind('primary key')
        string = string[0:m] + ');'
        return sep(string)

    if 'foreign key' in string:
        m = string.rfind('foreign key')
        string = string[0:m] + ');'
        return sep(string)


def load():
    # schema = open('/users/lzf/desktop/prpcitem_car.txt')
    # schema = open('/users/lzf/desktop/prpcopyitemkind.txt')
    schema = open('/users/lzf/desktop/prplcompensate.txt')
    lines = schema.readlines(100000)
    string = ''
    for line in lines:
        string += get_str(line.lower())
    string = clean(string)
    print string


load()
