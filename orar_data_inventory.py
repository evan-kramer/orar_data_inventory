# -*- coding: utf-8 -*-
"""
Created on Tue Dec 15 15:13:40 2020

@author: evan.kramer
"""

# Set up
import pandas as pd
import sqlalchemy as sa
# import pyodbc
import os

# Create engine
engine = (sa.create_engine("mssql+pyodbc://{user}:{password}@{server}"
                           .format(user = 'evan.kramer',
                                   password = os.getenv('quickbase_pwd'),
                                   server = 'OSSEDAARPRD02'),
                           fast_executemany = True))

# Get all databases
dbs = pd.read_sql('SELECT name, database_id, create_date FROM sys.databases', engine)

# Get all tables and column properties
tables = pd.DataFrame()
for db in dbs.name:
    try: 
        tables = pd.concat([tables, 
                            pd.read_sql("SELECT * FROM {db}.information_schema.columns".format(db = db), engine)])
    except:
        pass
tables.to_csv('prd02_table_list.csv', index = False)
