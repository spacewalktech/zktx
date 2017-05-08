# -*- coding: utf-8 -*-：
# 生成测试数据

import time
import os

o = '/data/spacewalk/origin_file/tmp'
r = '/data/spacewalk/origin_file/spark/test/full/'
s = '/data/spacewalk/origin_file/spark/test/incremental/'


def get_time():
    return time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))


def get_path():
    e = time.strftime('%Y%m%d_%H_%M_%S', time.localtime(time.time()))
    p = ''
    if q == 0:
        p = r + e
    else:
        p = s + e
    os.mkdir(p)
    return p


def get_array(y):
    array = []
    if y == 0:
        # 首次全量
        for i in range(1, 10001):
            i = str(i)
            array.append(i + '|' + 'name' + i + '|' + '1' + '|' + get_time() + '|' + ' is a good person' + '\n')
    else:
        '''
            1 10001~17000 17001~18000 18001~20000
            2 20001~27000 27001~28000 28001~30000
            ...
            10 100000~107000 107001~108000 108001~110000
            11 110000~117000 117001~118000 118001~120000
        '''
        # 新增
        for i in range(y * 10000 + 1, y * 10000 + 10000 + 1):
            i = str(i)
            array.append(i + '|' + 'name' + i + '|' + '1' + '|' + get_time() + '|' + ' is a good person' + '\n')
        # 修改
        for i in range((y-1) * 10000 + 7000 + 1, (y-1) * 10000 + 8000 + 1):
            i = str(i)
            array.append(i + '|' + 'name' + i + '|' + '2' + '|' + get_time() + '|' + ' is updated ' + '\n')
    return array


def get_array_del(y):
    array = []
    # 删除
    for i in range((y-1) * 10000 + 8000 + 1, y * 10000 + 1):
        i = str(i)
        array.append(i + '|' + 'name_delete' + '|' + '1' + '|' + get_time() + '|' + ' is deleted' + '\n')
    return array


def load(z):
    p = get_path()
    f = None
    if z > 0:
        f = file(p + '/data_insert_updated.txt', 'w+')
        f.writelines(get_array(z))
        f = file(p + '/data_deleted.txt', 'w+')
        f.writelines(get_array_del(z))
    else:    
        f = file(p + '/data_full.txt', 'w+')
        f.writelines(get_array(z))
    os.system("cp %s %s" % (o + '/schema.json', p + '/schema.json'))
    os.system("cp %s %s" % (o + '/upload_completed', p + '/upload_completed'))
    f.close()


q = 0

while True:
    load(q)
    q += 1
    print q
    time.sleep(30)
