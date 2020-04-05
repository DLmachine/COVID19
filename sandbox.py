#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan 22 16:17:40 2019

@author: isaac_weintraub_admin
"""

import scipy as sp # Import the SciPy Library Modules
import numpy as np # Import the NimPy Library Modules
from matplotlib import pyplot as plt # We will need to generate plates later
import pandas as pd
print("imported packages...")

# Name the path variables of interest
path    = 'COVID-19/csse_covid_19_data/csse_covid_19_time_series/'
cUS     = 'time_series_covid19_confirmed_US.csv'
cGlobe  = 'time_series_covid19_confirmed_global.csv'
dGlobe  = 'time_series_covid19_deaths_global.csv'
rGlobe  = 'time_series_covid19_recovered_global.csv'
popPath = 'population/data/population.csv'

# Necessary to build a MATLAB like struct in Python
class D:    # Create an empty class called D
    pass
data = D() # made a data varaiable which is a class of (empty class)


# Read the data from the repositry and store as data
cUS    = pd.read_csv(path+cUS)
cGlobe = pd.read_csv(path+cGlobe)
dGlobe = pd.read_csv(path+dGlobe)
rGlobe = pd.read_csv(path+rGlobe)
print('CSV data and stored into data structure...')
pop    = pd.read_csv(popPath) 
# Make sure to check data_frame.dftype
# this will ensure that data is being loaded as it's proper data type

# Provide statistics on the data
# pop.describe(include="all")

pop["Country Name"]
pop["Year"]
pop["Value"]

countryName = pop["Country Name"]                  # Gather a list of all country names 
ountryNameUnique = countryName.drop_duplicates()   # Unique country names
for Country in ountryNameUnique:
    popData = pop[pop["Country Name"]==Country]    # Section off the population data for the present country
    recentYear = max(popData["Year"])              # Obtain the maximum population of that country
    popTemp = popData[popData["Year"]==recentYear] # Obtain the row which coresponds to that year for the specific country
    popCountry = max(popTemp["Value"])             # Obtain the maximum population value, in case there were two entries for a year
print('Done!')





'''
for Country in countryNameUnique:
    print(Country)


rows    = pop.shape[0]
columns = pop.shape[1]


X = np.linspace(-np.pi, np.pi, 256)
C, S = np.cos(X), np.sin(X)

plt.plot(X, C)
plt.plot(X, S)

plt.show()

'''






