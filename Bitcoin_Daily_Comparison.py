# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import ccxt
import time
from datetime import datetime
from datetime import timedelta
start = datetime(2012, 1, 1)
now = datetime.now()
end=start + timedelta(days=1)
plt.figure(0)
superdata=[]
#------------------------------------------------------------------------------
year_difference=now.year-start.year
date_array=[]
# plt.rc('axes',prop_cycle = cycler_op1)
#------------------------------------------------------------------------------
difference=now-start
days_difference=int(difference.days)
limit_difference=24*12
start2=round(start.timestamp()*1000)
e = ccxt.binance()
e.load_markets()
crypto='BTCUSDT'
#------------------------------------------------------------------------------
for i in range(0,days_difference+1):
    print(start)
    date_array.append(start)
    data = e.fetch_ohlcv('BTCUSDT','5m',since=start2,limit=limit_difference)
    header = ['Timestamp', 'Open', 'High', 'Low', 'Close', 'Volume']
    df = pd.DataFrame(data, columns=header)
    df.insert(loc=1,column='Date',value=df['Timestamp'].apply(lambda date: pd.Timestamp(time.ctime(date/1000.))))
    price=df.Close.values
    price_rescaled_array=[]
    for j in range(0, len(price)):
        price_rescaled=100*price[j]/price[0]
        price_rescaled_array.append(price_rescaled)
    superdata.append(price_rescaled_array)
    start=start + timedelta(days=1)
    end=start + timedelta(days=1)
    # plt.plot(superdata[i])
    start2=round(start.timestamp()*1000)
# plt.legend(date_array)
plt.close()
#------------------------------------------------------------------------------
for j in range(1,30):
    index=np.linspace(0,limit_difference,num=limit_difference+1)
    A=int(65*limit_difference/100)
    C=A-1
    day_to_pick=-j
    benchmark_1=superdata[day_to_pick][0:A]
    benchmark_2=superdata[day_to_pick][C::]
    index_1=index[0:A]
    B=len(superdata[day_to_pick])
    index_2=index[C:B]
    difference_values_sum_array=[]
    for i in range(0,len(superdata)+day_to_pick):
        mobile=superdata[i][0:A]
        difference_values=np.subtract(benchmark_1,mobile)
        difference_sum=np.sum(np.abs(difference_values))
        print(difference_sum,i)
        difference_values_sum_array.append(difference_sum)
        
    difference_values_sum_array_2=np.array(difference_values_sum_array)
    best_array=difference_values_sum_array_2.argsort()[:3]
    
    # best_fit=np.argmin(difference_values_sum_array)
    plt.figure()
    plt.plot(index_1,benchmark_1,'g')
    plt.plot(index_2,benchmark_2,'r')
    plt.plot(superdata[best_array[0]],'b--')
    plt.plot(superdata[best_array[1]],'m-.')
    plt.plot(superdata[best_array[2]],'c-')
    plt.legend([date_array[day_to_pick],date_array[day_to_pick],date_array[best_array[0]],date_array[best_array[1]],date_array[best_array[2]]])
    plt.savefig('Chart'+str(j)+'.jpeg')
    plt.close