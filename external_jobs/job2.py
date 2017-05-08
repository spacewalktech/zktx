from context.data_context import DataContext

dc = DataContext()
df = dc.getDataFrameByDBTable("spark", "test_10")
df.show()

df.createOrReplaceTempView("test")
new_df = dc.sparkSession.sql("SELECT id, name from test")
#new_df.show()
print(new_df.schema)
dc.saveDataFrame(new_df, "spark", "test_11", True)
