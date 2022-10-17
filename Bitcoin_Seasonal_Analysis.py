# -*- coding: utf-8 -*-
import math
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
import matplotlib.pyplot as plt
import time
import datetime
import ccxt
from datetime import datetime
from datetime import timedelta
#Fetching Data since one year ago
today = datetime.now()
since = today.replace(year=today.year-5)
difference=today-since
limit=int(difference.days)
since2=round(since.timestamp()*1000)
e = ccxt.binance()
e.load_markets()
crypto='BTCUSDT'
data = e.fetch_ohlcv('BTCUSDT','1d',since=since2,limit=limit)
header = ['Timestamp', 'Open', 'High', 'Low', 'Close', 'Volume']
df = pd.DataFrame(data, columns=header)
df.insert(loc=1,column='Date',value=df['Timestamp'].apply(lambda date: pd.Timestamp(time.ctime(date/1000.))))
plt.plot(df.Date,df.Close)
#Calculate Percentage Differences
df['Daily_Return'] = df.Close.pct_change()
df['Cumulative_Return']=(1 + df.Daily_Return).cumprod()-1
df['Close_Standard']=(df.Cumulative_Return+1)*df.Close.iloc[0]
#Calculate weekdays and weekdays values
df['Month']=pd.to_datetime(df.Date).dt.month_name()
df['Month_Value']=pd.to_datetime(df.Date).dt.month
#Skipping first row
df_new=df.iloc[1::]
# df.Daily_Return.reset_index()
#Building new pandas dataframe by isolating weekend and no weekend days
df_january=df[['Daily_Return','Month_Value']][df['Month_Value']==1]
df_january['Cumulative_Return']=(1 + df_january.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_february=df[['Daily_Return','Month_Value']][df['Month_Value']==2]
df_february['Cumulative_Return']=(1 + df_february.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_march=df[['Daily_Return','Month_Value']][df['Month_Value']==3]
df_march['Cumulative_Return']=(1 + df_march.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_april=df[['Daily_Return','Month_Value']][df['Month_Value']==4]
df_april['Cumulative_Return']=(1 + df_april.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_may=df[['Daily_Return','Month_Value']][df['Month_Value']==5]
df_may['Cumulative_Return']=(1 + df_may.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_june=df[['Daily_Return','Month_Value']][df['Month_Value']==6]
df_june['Cumulative_Return']=(1 + df_june.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_july=df[['Daily_Return','Month_Value']][df['Month_Value']==7]
df_july['Cumulative_Return']=(1 + df_july.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_august=df[['Daily_Return','Month_Value']][df['Month_Value']==8]
df_august['Cumulative_Return']=(1 + df_august.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_september=df[['Daily_Return','Month_Value']][df['Month_Value']==9]
df_september['Cumulative_Return']=(1 + df_september.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_october=df[['Daily_Return','Month_Value']][df['Month_Value']==10]
df_october['Cumulative_Return']=(1 + df_october.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_november=df[['Daily_Return','Month_Value']][df['Month_Value']==11]
df_november['Cumulative_Return']=(1 + df_november.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
df_december=df[['Daily_Return','Month_Value']][df['Month_Value']==12]
df_december['Cumulative_Return']=(1 + df_december.Daily_Return).cumprod() - 1
#------------------------------------------------------------------------------
Cumulative_Return_january=df_january.Cumulative_Return.iloc[-1]*100
Cumulative_Return_february=df_february.Cumulative_Return.iloc[-1]*100
Cumulative_Return_march=df_march.Cumulative_Return.iloc[-1]*100
Cumulative_Return_april=df_april.Cumulative_Return.iloc[-1]*100
Cumulative_Return_june=df_june.Cumulative_Return.iloc[-1]*100
Cumulative_Return_july=df_july.Cumulative_Return.iloc[-1]*100
Cumulative_Return_august=df_august.Cumulative_Return.iloc[-1]*100
Cumulative_Return_september=df_september.Cumulative_Return.iloc[-1]*100
Cumulative_Return_october=df_october.Cumulative_Return.iloc[-1]*100
Cumulative_Return_november=df_november.Cumulative_Return.iloc[-1]*100
Cumulative_Return_december=df_december.Cumulative_Return.iloc[-1]*100
Y=[Cumulative_Return_january,Cumulative_Return_february,Cumulative_Return_march,Cumulative_Return_april,Cumulative_Return_june,Cumulative_Return_july,Cumulative_Return_august,Cumulative_Return_september,Cumulative_Return_october,Cumulative_Return_november,Cumulative_Return_december]
X=['January','February','March','April','June','July','August','September','October','November','December']
plt.figure(0)
plt.bar(X,Y)
plt.title('Cumulative Return for '+ str(crypto) +' in percentage since \n' + str(since) + '\n until \n' + str(today))













