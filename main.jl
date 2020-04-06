#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# PROGRAM NAME: main.jl
# DESCRIPTION:  This program reads the most recent data from
#               the CDC and plots for data visualization purposes
# AUTHOR:       Isaac Weintraub April 2020
# VERSION	0.1
# REQ.PACKAGES:	CSV
# 
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
run(`git fetch`)    # Get the latest data
using CSV           # Need to read the CSV data
using Plots         # Allows the genation of plots
using DataFrames    # Used for handliong the csv file (contains strings and numbers)
using ProgressMeter # Used for making the progress meeter
pyplot()            # Use the python plotting backend
popStates = CSV.read("USA.csv",header=true)     # Read the population data from the united states
casesUSA   = CSV.read("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv",header=true) # Read the latests data from JOHNS HOPKINS
casesUSAstateList = casesUSA[:,7]       # Gather a list of all the states
n = size(popStates)[1]                  # the number of provinces and states of the USA
@showprogress 0.01 for i = 1:n          # show a progress meter and for loop through the states
    state = popStates[i,1]              # get the name of the current state (STRING)
    pop = popStates[i,2]                # get the population of the current state (FLOAT)
    index = casesUSA[:,7].==state       # get the subset of indexies whicih corespond to data for that state
    stateData = casesUSA[index,12:end]  # parse the subset of the data for the state of interest
    M = convert(Array, stateData[1:end,:])  # Conver the data to a matrix for manipulation reasons
    stateCases = sum(M,dims=1)          # summing is easier as a matrix than as a data frame NEED THE TOTAL NUMBER OF CASES in each state
    # Plot the current state or provices
    plot()
    plot!(1:size(stateCases)[2],
        100*stateCases[1,:]./pop,lab=state,
        scale=:log10,
        yticks = [1e-6,1e-5,1e-4,1e-3,1e-2,1e-1,1,1e1,1e2],
        yaxis="Percent of State", xaxis="Days since Jan 22")
    p = plot!(xscale=:identity,xticks=0:10:100)
    xlims!((0,100))
    ylims!((1e-6,100))
    png(p,"StateFigures/$state.png")
end
print("Done")