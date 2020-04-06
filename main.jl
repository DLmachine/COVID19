#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# PROGRAM NAME: main.jl
# DESCRIPTION:  This program reads the most recent data from
#               the CDC and plots for data visualization purposes
# AUTHOR:       Isaac Weintraub April 2020
# VERSION	0.1
# REQ.PACKAGES:	CSV
# 
#
#-----------------------------------------------------------
using CSV
using Plots
using DataFrames
using LaTeXStrings
using ProgressMeter
plotly()
# Read the csv files into julia memory
popStates = CSV.read("USA.csv",header=true)
casesUSA   = CSV.read("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv",header=true)
# Run a for loop though each state
casesUSAstateList = casesUSA[:,7]
n = size(popStates)[1]
@showprogress 0.01 for i = 1:n
#i = 1
state = popStates[i,1]
pop = popStates[i,2]
index = casesUSA[:,7].==state
stateData = casesUSA[index,12:end]
M = convert(Array, stateData[1:end,:])
stateCases = sum(M,dims=1)
plot()
plot!(1:size(stateCases)[2],100*stateCases[1,:]./pop,lab=state, scale=:log10,yticks = [1e-6,1e-5,1e-4,1e-3,1e-2,1e-1,1,1e1,1e2],yaxis="Percent of State", xaxis="Days since Jan 22")
p = plot!(xscale=:identity,xticks=0:10:100)
xlims!((0,100))
ylims!((1e-6,100))
png(p,"StateFigures/$state.png")
end
print("Done")