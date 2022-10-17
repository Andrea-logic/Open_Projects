# -*- coding: utf-8 -*-
import math
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import datetime
from datetime import datetime
from datetime import timedelta
#Fetching Data since one year ago
MoM_rate_array=[-0.3/100,-0.2/100,-0.1/100,0,0.1/100,0.2/100,0.3/100,0.4/100]
MoM_rate_string=['-0.3 %','-0.2 %','-0.1 %','0 %','0.1 %','0.2 %','0.3 %','0.4 %']
plt.figure(0)
for z in range(0,len(MoM_rate_array)):
    CPI_dataframe = pd.read_excel('CPI.xlsx')
    MoM_rate=MoM_rate_array[z]
    CPI_dataframe.iloc[10,9]=CPI_dataframe.iloc[10,8]*(1+MoM_rate)
    CPI_dataframe.iloc[10,10]=CPI_dataframe.iloc[10,9]*(1+MoM_rate)
    CPI_dataframe.iloc[10,11]=CPI_dataframe.iloc[10,10]*(1+MoM_rate)
    CPI_dataframe.iloc[10,12]=CPI_dataframe.iloc[10,11]*(1+MoM_rate)
    #------------------------------------------------------------------------------
    CPI_dataframe.iloc[11,1]=CPI_dataframe.iloc[10,12]*(1+MoM_rate)
    CPI_dataframe.iloc[11,2]=CPI_dataframe.iloc[11,1]*(1+MoM_rate)
    CPI_dataframe.iloc[11,3]=CPI_dataframe.iloc[11,2]*(1+MoM_rate)
    CPI_dataframe.iloc[11,4]=CPI_dataframe.iloc[11,3]*(1+MoM_rate)
    CPI_dataframe.iloc[11,5]=CPI_dataframe.iloc[11,4]*(1+MoM_rate)
    CPI_dataframe.iloc[11,6]=CPI_dataframe.iloc[11,5]*(1+MoM_rate)
    CPI_dataframe.iloc[11,7]=CPI_dataframe.iloc[11,6]*(1+MoM_rate)
    CPI_dataframe.iloc[11,8]=CPI_dataframe.iloc[11,7]*(1+MoM_rate)
    CPI_dataframe.iloc[11,9]=CPI_dataframe.iloc[11,8]*(1+MoM_rate)
    CPI_dataframe.iloc[11,10]=CPI_dataframe.iloc[11,9]*(1+MoM_rate)
    CPI_dataframe.iloc[11,11]=CPI_dataframe.iloc[11,10]*(1+MoM_rate)
    CPI_dataframe.iloc[11,12]=CPI_dataframe.iloc[11,11]*(1+MoM_rate)
    print(CPI_dataframe)
    CPI_dataframe=CPI_dataframe.drop(columns=['Year'])
    #------------------------------------------------------------------------------
    #Building Inflation Dataframe
    Columns=['January','February','March','April','May','June','July','August','September','October','November','December']
    Ultra = pd.DataFrame()
    for i in range(0,12):
        inflation_array=[]
        for j in range(0,11):
            Initial_CPI=CPI_dataframe.iloc[j,i]
            Final_CPI=CPI_dataframe.iloc[j+1,i]
            YoY_Inflation_Rate=100*(Final_CPI-Initial_CPI)/Initial_CPI
            inflation_array.append(YoY_Inflation_Rate)
            Month=Columns[i]
        df=pd.DataFrame({Month:inflation_array})
        Ultra = pd.concat([Ultra, df], axis=1)
    
    # Year_array=['2013','2014','2015','2016','2017','2018','2019','2020','2021','2022','2023']
    # Ultra['Year']=Year_array
    plt.plot(Ultra.iloc[9])
    print(Ultra)
plt.title('YoY Inflation Rate depending on the \n MoM rate increase (in the legend)')
plt.grid()
plt.legend(MoM_rate_string)
