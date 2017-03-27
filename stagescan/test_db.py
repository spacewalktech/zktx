from common.db.db_config import session as sess
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column
from sqlalchemy.dialects.mysql import INTEGER, DATETIME, TEXT, TINYINT, VARCHAR
from sqlalchemy.schema import ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import desc

Base = declarative_base()
# tb_task_queue table
class Animal(Base):
    __tablename__ = "animals"

    id = Column('id', INTEGER(11), primary_key=True)
    name = Column('name', VARCHAR(50))

sq = sess.query(Animal).order_by(desc(Animal.id))
for s in sq:
    print(s)
    print(s.id)