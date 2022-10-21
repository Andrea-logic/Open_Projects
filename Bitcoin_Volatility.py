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
start_date = datetime(2017, 1, 1)
end_date = datetime.now()
# end=start + relativedelta(years=1)
difference=end_date-start_date
limit=int(difference.days)
start=round(start_date.timestamp()*1000)
e = ccxt.binance()
e.load_markets()
crypto='BTCUSDT'
#------------------------------------------------------------------------------
control=500
frames=[]
module=int(limit/control)
for i in range(0,4):
    data = e.fetch_ohlcv('BTCUSDT','1d',since=start,limit=control)
    header = ['Timestamp', 'Open', 'High', 'Low', 'Close', 'Volume']
    df0 = pd.DataFrame(data, columns=header)
    df0.insert(loc=1,column='Date',value=df0['Timestamp'].apply(lambda date: pd.Timestamp(time.ctime(date/1000.))))
    start=df0.Date.iloc[-1]+timedelta(days=1)
    start=round(start.timestamp()*1000)
    frames.append(df0)
    print(i)
df = pd.concat(frames)

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
df['Log_Returns'] = np.log(df['Close']/df['Close'].shift())
df['Daily_Volatility_5_Windows']=100*df['Log_Returns'].rolling(5).std()
df['Daily_Volatility_7_Windows']=100*df['Log_Returns'].rolling(7).std()
df['Daily_Volatility_15_Windows']=100*df['Log_Returns'].rolling(15).std()
df['Daily_Volatility_30_Windows']=100*df['Log_Returns'].rolling(30).std()
plt.figure(figsize=(15, 10))
plt.title('Rolling Volatility for varioys windows (since 2017) \n for '+str(crypto))
plt.xlabel('Time')
plt.ylabel('Volatility (Percentage)')
plt.plot(df.Date,df.Daily_Volatility_5_Windows)
plt.plot(df.Date,df.Daily_Volatility_7_Windows)
plt.plot(df.Date,df.Daily_Volatility_15_Windows)
plt.plot(df.Date,df.Daily_Volatility_30_Windows)
plt.legend(['Window=5 days','Window=7 days','Window=15 days','Window=30 days'])
plt.savefig('Rolling Volatility of '+str(crypto)+' since 2017')
plt.close()
#------------------------------------------------------------------------------
plt.figure(figsize=(15, 10))
plt.title('Rolling Volatility for varioys windows (last year) \n for '+str(crypto))
plt.xlabel('Time')
plt.ylabel('Volatility (Percentage)')
plt.plot(df.Date[-365:-1],df.Daily_Volatility_5_Windows[-365:-1])
plt.plot(df.Date[-365:-1],df.Daily_Volatility_7_Windows[-365:-1])
plt.plot(df.Date[-365:-1],df.Daily_Volatility_15_Windows[-365:-1])
plt.plot(df.Date[-365:-1],df.Daily_Volatility_30_Windows[-365:-1])
plt.legend(['Window=5 days','Window=7 days','Window=15 days','Window=30 days'])
plt.savefig('Rolling Volatility of '+str(crypto)+' in the last year')
plt.close()
#------------------------------------------------------------------------------
plt.figure(figsize=(15, 10))
plt.title('Rolling Volatility for varioys windows (last 100 days) \n for '+str(crypto))
plt.xlabel('Time')
plt.ylabel('Volatility (Percentage)')
plt.plot(df.Date[-100:-1],df.Daily_Volatility_5_Windows[-100:-1])
plt.plot(df.Date[-100:-1],df.Daily_Volatility_7_Windows[-100:-1])
plt.plot(df.Date[-100:-1],df.Daily_Volatility_15_Windows[-100:-1])
plt.plot(df.Date[-100:-1],df.Daily_Volatility_30_Windows[-100:-1])
plt.legend(['Window=5 days','Window=7 days','Window=15 days','Window=30 days'])
plt.savefig('Rolling Volatility of '+str(crypto)+' in the last 100 days')
plt.close()