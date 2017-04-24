# -*- coding: utf-8 -*-:
# 提供thriftserver的功能

from impala.dbapi import connect

conn = connect(host='192.168.1.51', port=10000, auth_mechanism='PLAIN')

cur = conn.cursor()

cur.execute('show databases')

print(cur.fetchall())

# import sys
# from thrift import Thrift
# from thrift.transport import TSocket
# from thrift.transport import TTransport
# from thrift.protocol import TBinaryProtocol
#
# transport = TSocket.TSocket('192.168.30.201', 10000)
# transport = TTransport.TBufferedTransport(transport)
# protocol = TBinaryProtocol.TBinaryProtocol(transport)
#
# client = ThriftHive.Client(protocol)