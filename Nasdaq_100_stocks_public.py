# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import ccxt
import time
from datetime import datetime
from datetime import timedelta
import wbgapi as wb
from fmp_python.fmp import FMP
API_KEY='*********************'
#GET Financial Ratios
try:
    # For Python 3.0 and later
    from urllib.request import urlopen
except ImportError:
    # Fall back to Python 2's urllib2
    from urllib2 import urlopen

import certifi
import json

def get_jsonparsed_data(url):
    """
    Receive the content of ``url``, parse it as JSON and return the object.

    Parameters
    ----------
    url : str

    Returns
    -------
    dict
    """
    response = urlopen(url, cafile=certifi.where())
    data = response.read().decode("utf-8")
    return json.loads(data)


#------------------------------------------------------------------------------
url = ("https://financialmodelingprep.com/api/v3/nasdaq_constituent?apikey="+str(API_KEY))
json_nasdaq_stocks=get_jsonparsed_data(url)
df_nasdaq_stocks = pd.json_normalize(json_nasdaq_stocks)
nasdaq_symbol_list=df_nasdaq_stocks.symbol.values.tolist()
df_stocks=pd.DataFrame(columns=['Symbol','PE','PEG','PB','PS'])
#------------------------------------------------------------------------------
#Taking Data from Nasda1 100
for i in range(0,len(nasdaq_symbol_list)):
    df_ratios=pd.DataFrame()
    url2 = ("https://financialmodelingprep.com/api/v3/ratios/"+str(nasdaq_symbol_list[i])+"?period=quarter&apikey="+str(API_KEY))
    json_ratios=get_jsonparsed_data(url2)
    df_ratios = pd.json_normalize(json_ratios)
    print(df_ratios.iloc[0].date)
    PE=df_ratios.iloc[0].priceEarningsRatio
    PEG=df_ratios.iloc[0].priceEarningsToGrowthRatio
    PB=df_ratios.iloc[0].priceToBookRatio 
    PS=df_ratios.iloc[0].priceToSalesRatio
    Row = pd.DataFrame({'Symbol': nasdaq_symbol_list[i],'PE':PE,'PEG':PEG,'PB':PB,'PS':PS},index=[i])
    df_stocks = df_stocks.append(Row, ignore_index=False)
#------------------------------------------------------------------------------
PE_array=df_stocks.PE.values.tolist()
PB_array=df_stocks.PB.values.tolist()
PS_array=df_stocks.PS.values.tolist()
PEG_array=df_stocks.PEG.values.tolist()

#------------------------------------------------------------------------------
y = PEG_array
x = PE_array
n = nasdaq_symbol_list

fig, ax = plt.subplots(figsize=(15, 10))
ax.scatter(x, y)
plt.xlim([0, 20])
plt.ylim([0, 2])
plt.title('PEG vs PE Nasdaq 100 (Most Recent Data)')
plt.xlabel('PE')
plt.ylabel('PEG')
plt.axhline(y = 1, color = 'r', linestyle = '-')
plt.axvline(x = 15, color = 'r', linestyle = '-')
for i, txt in enumerate(n):
    ax.annotate(txt, (x[i], y[i]),xytext=(x[i], y[i]+0.05),fontsize=8)
plt.savefig('PEG vs PE Nasdaq 100.jpeg')
plt.close
#------------------------------------------------------------------------------
plt.figure(1)
y1 = PB_array
n = nasdaq_symbol_list

fig, ax = plt.subplots(figsize=(15, 10))
ax.scatter(x, y1)
plt.xlim([0, 20])
plt.ylim([0, 20])
plt.title('PB vs PE Nasdaq 100 (Most Recent Data)')
plt.xlabel('PE')
plt.ylabel('PB')
plt.axhline(y = 1, color = 'r', linestyle = '-')
plt.axvline(x = 15, color = 'r', linestyle = '-')
for i, txt in enumerate(n):
    ax.annotate(txt, (x[i], y1[i]),xytext=(x[i], y1[i]+0.05),fontsize=8)
plt.savefig('PB vs PE Nasdaq 100.jpeg')
plt.close
#------------------------------------------------------------------------------
plt.figure(2)
y2 = PS_array
n = nasdaq_symbol_list

fig, ax = plt.subplots(figsize=(15, 10))
ax.scatter(x, y2)
plt.xlim([0, 20])
plt.ylim([0, 20])
plt.title('PS vs PE Nasdaq 100 (Most Recent Data)')
plt.xlabel('PE')
plt.ylabel('PS')
plt.axhline(y = 1, color = 'r', linestyle = '-')
plt.axvline(x = 15, color = 'r', linestyle = '-')
for i, txt in enumerate(n):
    ax.annotate(txt, (x[i], y2[i]),xytext=(x[i], y2[i]+0.05),fontsize=8)
plt.savefig('PS vs PE Nasdaq 100.jpeg')
plt.close
#------------------------------------------------------------------------------
plt.figure(3)
x2= PB_array
y3 = PS_array
n = nasdaq_symbol_list

fig, ax = plt.subplots(figsize=(15, 10))
ax.scatter(x2, y3)
plt.xlim([0, 20])
plt.ylim([0, 20])
plt.title('PS vs PB Nasdaq 100 (Most Recent Data)')
plt.xlabel('PB')
plt.ylabel('PS')
plt.axhline(y = 15, color = 'r', linestyle = '-')
plt.axvline(x = 15, color = 'r', linestyle = '-')
for i, txt in enumerate(n):
    ax.annotate(txt, (x2[i], y3[i]),xytext=(x2[i], y3[i]+0.05),fontsize=8)
plt.savefig('PS vs PB Nasdaq 100.jpeg')
plt.close
#------------------------------------------------------------------------------
df_stocks_gold=df_stocks[(df_stocks.PE>0) & (df_stocks.PE <15) & (df_stocks.PEG >0) & (df_stocks.PEG<1)]
print(df_stocks_gold)
stocks_gold_percentage=100*(len(df_stocks_gold)/len(df_stocks))
print(stocks_gold_percentage)
Y=[len(df_stocks_gold),len(df_stocks)]
X=['Constituents with \n 0<PE<15 and \n and 0<1<PEG','Number of index constituents']
plt.figure(4)
plt.bar(X,Y)
plt.title('Nasdaq 100 Constituents Breakdown')
plt.savefig('Nasdaq 100 Constituents Breakdown.jpeg')
plt.close
