#!/usr/bin/env python
# coding: utf-8

# <h1>目录<span class="tocSkip"></span></h1>
# <div class="toc"><ul class="toc-item"></ul></div>

# In[ ]:


# 连接数据库的功能
class MysqlOperating:
    # 输出化方法, 当对象被实例化的时候, 就自动建立好和数据库的连接了
    def __init__(self , host ,user,password,database,charset,port = 3306):        
        import pymysql
        self.connect = pymysql.connect(host = host,
                         port=port,
                         user = user,
                         password= password,
                         database = database,
                         charset = charset)
        # 光标也直接构建好
        self.cursor = self.connect.cursor()
        print(self.cursor)
    def create(self, table,*args ):
        """创建表格功能
        table:表名
        *args: 每一个建立的字段及数据类型"""
        columns = ','.join(args)
        sql = "create table {} ({})".format(table,columns)
        print(sql)
        self.cursor.execute(sql)
        return '创建'+table+'成功'
    # 写一个插入功能
    def insert(self , table, data ):
        """插入数据
        table: 表名
        data: 数据二维表格式"""
        # %s 的个数有data里面有几列决定的
        n = len(data[0])
        s = ','.join(["%s" for i in range(n)])
        self.cursor.executemany("""insert into {} values({})""".format(table,s),data)
        # 提交
        self.connect.commit()
        
    # 查询功能
    def select(self , col, table ,condition = None):
        """查询语句
        col : 列名
        table : 表名
        condition : 查询条件"""
        sql = 'select {} from {}'.format(col, table)
        # 判断是否传入了查询条件
        if condition:
            # 在刚才的sql语法后面添加过滤条件
            sql += " where "+ condition
        print(sql)
        # 执行查询
        self.cursor.execute(sql)
        # 提取数据,提取全部数据
        self.data = self.cursor.fetchall()
        return self.data
    # 删除数据    
    def delete(self, table ,condition=None):
        sql = "delete from "+table
        if condition:
            sql+= " where "+condition
        print(sql)
        self.cursor.execute(sql)
        self.connect.commit() # 提交
        return '删除成功'
    # 更新数据
    def update(self,table,key,value,condition=None ):
        sql = "update {} set {} = '{}' where {}".format(table,key,value,condition)
        self.cursor.execute(sql)
        self.connect.commit() # 提交
        return '更改成功'

