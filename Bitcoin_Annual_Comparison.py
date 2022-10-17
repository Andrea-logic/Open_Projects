# -*- coding: utf-8 -*-
import math
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import time
import ccxt
import datetime
from datetime import datetime
from datetime import timedelta
import vectorbt as vbt
from dateutil.relativedelta import relativedelta
start = datetime(2010, 1, 1)
now = datetime.now()
end=start + relativedelta(years=1)
plt.figure(0)
superdata=[]
#------------------------------------------------------------------------------
year_difference=now.year-start.year
year_array=[]
# plt.rc('axes',prop_cycle = cycler_op1)
#------------------------------------------------------------------------------
difference=end-start
limit2=int(difference.days)
start2=round(start.timestamp()*1000)
e = ccxt.binance()
e.load_markets()
crypto='BTCUSDT'
#------------------------------------------------------------------------------
for i in range(0,year_difference+1):
    year_array.append(start.year)
    data = e.fetch_ohlcv('BTCUSDT','1d',since=start2,limit=limit2)
    header = ['Timestamp', 'Open', 'High', 'Low', 'Close', 'Volume']
    df = pd.DataFrame(data, columns=header)
    df.insert(loc=1,column='Date',value=df['Timestamp'].apply(lambda date: pd.Timestamp(time.ctime(date/1000.))))
    price=df.Close.values
    price_rescaled_array=[]
    for j in range(0, len(price)):
        price_rescaled=100*price[j]/price[0]
        price_rescaled_array.append(price_rescaled)
    superdata.append(price_rescaled_array)
    start=start + relativedelta(years=1)
    end=start + relativedelta(years=1)
    plt.plot(superdata[i])
    start2=round(start.timestamp()*1000)
plt.legend(year_array)


benchmark=superdata[-1]
difference_values_array=[]
difference_values_sum_array=[]
for i in range(0,len(superdata)-1):
    mobile=superdata[i][0:len(benchmark)]
    difference_values=np.subtract(superdata[-1],mobile)
    difference_values_array.append(difference_values)
    difference_sum=np.sum(np.abs(difference_values))
    difference_values_sum_array.append(difference_sum)
    
best_fit=np.argmin(difference_values_sum_array)
plt.figure(1)
plt.plot(benchmark,'g')
plt.plot(superdata[best_fit],'b')
plt.legend([year_array[-1],year_array[best_fit]])