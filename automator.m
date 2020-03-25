%--------------------------------------------------------------------------
% Sandbox.m
%
% Description: This program first pulls the most recent data from Johns
% Hopkins' Github account which contains the most up to date CDC and WHO
% data. Using this data, a parser is used to gather the data for a country
% or province of interest. Plots are created to visulize the current
% outbreak of COVID19.
%  
% Author: Isaac Weintraub
%--------------------------------------------------------------------------
clear 
clc
close all
              
% Pull the most up-to-date information
%
% Uncomment or run this in the terminal the first time you run the code
%!git clone https://github.com/CSSEGISandData/COVID-19.git
%!git clone https://github.com/datasets/population.git
cd COVID-19
!git pull
cd ..
cd population
!git pull
cd ..

%
% Import the data from CSV format to matlab cell or matrix 
%
pops      = importdata("population/data/population.csv");
cases     = importdata("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv");
deaths    = importdata("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv");
recovered = importdata("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv");
popStates = importdata("USA.csv");
% Gather a list of countries and provinces
Country = cases.textdata(:,2);
Province = cases.textdata(:,1);

State = popStates.textdata(:,1);

% Display the Country List Allow User to Select Country of Interest
CountryShort = unique(Country);
ProvinceShort = unique(Province);

%%
for i = 1:length(CountryShort)              % Parse through all countries
    countryNameCell = CountryShort(i);      % Gather the country's name
    countryName = countryNameCell{1};       % Convert to a string
    isCountry = strcmp(Country,countryName);    % Selection vector
    if strcmp(countryName,'US')
        countryName = 'United States';
    end
    isCountryPops = strcmp(pops.textdata(:,1),countryName);
    popsData =  pops.data(isCountryPops,:); % Get the data for that country for all years on record
    [~,b]= max(popsData(:,1));
    popCountry = popsData(b,2);

    if ~isempty(b)
        isCountry = isCountry(2:end);               % Remove header line
        for j = 3:size(cases.data,2)-1
            casesCountry(j-2)     = sum(cases.data(isCountry,j));
            deathsCountry(j-2)    = sum(deaths.data(isCountry,j));
            recoveredCountry(j-2) = sum(recovered.data(isCountry,j));
        end
        days = 1:length(casesCountry);
        plotData(countryName,popCountry,casesCountry,deathsCountry,recoveredCountry)
        figureOut = gcf;
        saveas(figureOut,['Figures/' date '/' countryName '.jpg'])
        close all
    end
end
%% US STATES

for i = 1:length(ProvinceShort)
    provinceNameCell = ProvinceShort(i);
    stateName = provinceNameCell{1};
    isState = strcmp(State,stateName);
    popState = popStates.data(isState);
    for j = 3:size(cases.data,2)-1
            casesState(j-2)     = sum(cases.data(isState,j));
            deathsState(j-2)    = sum(deaths.data(isState,j));
            recoveredState(j-2) = sum(recovered.data(isState,j));
    end
    if ~isempty(popState)
    days = 1:length(casesState);
    plotData(stateName,popState,casesState,deathsState,recoveredState)
    figureOut = gcf;
    saveas(figureOut,['Figures/' date '/' stateName '.jpg'])
    close all
    end
end

