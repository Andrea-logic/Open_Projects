# -*- coding: utf-8 -*-
"""
Created on Fri Mar 25 10:03:02 2022

@author: proto
"""
import math
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import time
import ccxt
from datetime import datetime, date
from pandas import DataFrame
#Fetching Data since one year ago
today = datetime.now()
since = today.replace(year=today.year-12)
difference=today-since
limit=int(difference.days)
since2=round(since.timestamp()*1000)
e = ccxt.binance()
e.load_markets()
crypto='BTCUSDT'
data = e.fetch_ohlcv('BTCUSDT','1d',since=since2)
header = ['Timestamp', 'Open', 'High', 'Low', 'Close', 'Volume']
df = pd.DataFrame(data, columns=header)
df.insert(loc=1,column='Date',value=df['Timestamp'].apply(lambda date: pd.Timestamp(time.ctime(date/1000.))))
plt.plot(df.Date,df.Close)
#Calculate Percentage Differences
df['Daily_Return'] = df.Close.pct_change()
df['Cumulative_Return']=(1 + df.Daily_Return).cumprod()-1
df['Close_Standard']=(df.Cumulative_Return+1)*df.Close.iloc[0]
#Calculate weekdays and weekdays values
df['Weekdays']=pd.to_datetime(df.Date).dt.day_name()
df['Weekdays_Value']=pd.to_datetime(df.Date).dt.dayofweek
#Skipping first row
df_new=df.iloc[1::]
# df.Daily_Return.reset_index()
#Building new pandas dataframe by isolating weekend and no weekend days
df_noweekend=df[['Daily_Return','Weekdays_Value']][(df['Weekdays_Value']!=5) & (df['Weekdays_Value']!=6)]
df_noweekend['Cumulative_Return']=(1 + df_noweekend.Daily_Return).cumprod() - 1
df_weekend=df[['Daily_Return','Weekdays_Value']][(df['Weekdays_Value']==5) | (df['Weekdays_Value']==6)]
df_weekend['Cumulative_Return']=(1 + df_weekend.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
Cumulative_Return_Overall_Percentage=df.Cumulative_Return.iloc[-1]*100
Cumulative_Return_Noweekend_Percentage=df_noweekend.Cumulative_Return.iloc[-1]*100
Cumulative_Return_weekend_Percentage=df_weekend.Cumulative_Return.iloc[-1]*100
Y=[Cumulative_Return_Overall_Percentage,Cumulative_Return_Noweekend_Percentage,Cumulative_Return_weekend_Percentage]
X=['Overall','No weekends','Weekends']
plt.figure(0)
plt.bar(X,Y)
plt.title('Cumulative Return for '+ str(crypto) +' in percentage since \n' + str(since) + '\n until \n' + str(today))


