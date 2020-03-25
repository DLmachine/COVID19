%--------------------------------------------------------------------------
% Main.m
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
% Population Information for Countries of Interest

popUSA = 327.2e6;
popOH = 11.69e6;
popFL = 21.3e6;
popSK = 51.47e6;
popItaly =  60.48e6;
popFr = 66.99e6;
popIran = 81.16e6;
popSpain = 46.66e6;
popIceland = 364260;
popChina = 1.386e9;
popNY = 8.623e6;
popEarth = 7.53e9;

%
% Pull the most up-to-date information
%

% Uncomment or run this in the terminal the first time you run the code
%!git clone https://github.com/CSSEGISandData/COVID-19.git
cd COVID-19
!git pull
cd ..

%
% Import the data from CSV format to matlab cell or matrix 
%
cases     = importdata("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv");
deaths    = importdata("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv");
recovered = importdata("COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv");

Country = cases.textdata(:,2);
Province = cases.textdata(:,1);

% % %
% % % Display the Country List Allow User to Select Country of Interest
% % % 
% % CountryShort = unique(Country);
% % ProvinceShort = unique(Province);
% % list = CountryShort;
% % [choice,~] = listdlg('ListString',list);
% % isCountry = strcmp(Country,CountryShort(choice));     % Generate Index of Values for the chosen country
% % isCountry = isCountry(2:end);           % Remove Header
% % 
% % 
% % Population(choice)
% % switch(choice)
% %     case(162) % USA
% %         popC = 327.2e6;
% % end

%
% USA
isUSA = strcmp(Country,'US'); 
%isUSA(200:end) = 0;      % Ignore minor outlaying islands
isUSA = isUSA(2:end);     % Remove the header
% Ohio
isOhio = strcmp(Province,'Ohio');
isOhio = isOhio(2:end);
% FLorida
isFL   = strcmp(Province,'Florida');
isFL   = isFL(2:end);
% NY
isNY = strcmp(Province,'New York');
isNY = isNY(2:end);
% China
isChina = strcmp(Country,'China');
isChina = isChina(2:end);
% South Korea
isSK = strcmp(Country,'Korea, South');
isSK = isSK(2:end);
% Iran
isIran = strcmp(Country,'Iran');
isIran = isIran(2:end);
% Italy
isItaly = strcmp(Country,'Italy');
isItaly = isItaly(2:end);
% Spain
isSpain = strcmp(Country,'Spain');
isSpain = isSpain(2:end);
% France
isFrance = strcmp(Country,'France');
isFrance = isFrance(2:end);
% Iceland
isIceland = strcmp(Country,'Iceland');
isIceland = isIceland(2:end);
% Earth
isEarth = ones(size(isUSA));
isEarth = isEarth(2:end);



index = 0;
for i = 3:size(cases.data,2)-1
    
    casesUSA(i-2)     = sum(cases.data(isUSA,i));
    deathsUSA(i-2)    = sum(deaths.data(isUSA,i));
    recoveredUSA(i-2) = sum(recovered.data(isUSA,i));

    casesIceland(i-2)     = sum(cases.data(isIceland,i));
    deathsIceland(i-2)    = sum(deaths.data(isIceland,i));
    recoveredIceland(i-2) = sum(recovered.data(isIceland,i));
    
    casesItaly(i-2)     = sum(cases.data(isItaly,i));
    deathsItaly(i-2)    = sum(deaths.data(isItaly,i));
    recoveredItaly(i-2) = sum(recovered.data(isItaly,i));

    casesChina(i-2)     = sum(cases.data(isChina,i));
    deathsChina(i-2)    = sum(deaths.data(isChina,i));
    recoveredChina(i-2) = sum(recovered.data(isChina,i));
    
    casesOH(i-2)      = sum(cases.data(isOhio,i));
    deathsOH(i-2)      = sum(deaths.data(isOhio,i));
    recoveredOH(i-2)  = sum(recovered.data(isOhio,i));
    
    casesFL(i-2)      = sum(cases.data(isFL,i));
    deathsFL(i-2)      = sum(deaths.data(isFL,i));
    recoveredFL(i-2)  = sum(recovered.data(isFL,i));
    
    casesNY(i-2)      = sum(cases.data(isNY,i));
    deathsNY(i-2)      = sum(deaths.data(isNY,i));
    recoveredNY(i-2)  = sum(recovered.data(isNY,i));
    
    casesEarth(i-2)      = sum(cases.data(:,i));
    deathsEarth(i-2)     = sum(deaths.data(:,i));
    recoveredEarth(i-2)   = sum(recovered.data(:,i));
    
%     casesC(i-2)         = sum(cases.data(isCountry,i));
%     deathsC(i-2)        = sum(deaths.data(isCountry,i));
%     recoveredC(i-2)     = sum(recovered.data(isCountry,i));
end

days = 1:length(casesUSA);


%
% Plotting the Data
% 

plotData('Earth',popEarth,casesEarth,deathsEarth,recoveredEarth)
plotData('USA',popUSA,casesUSA,deathsUSA,recoveredUSA)
plotData('Iceland',popIceland,casesIceland,deathsIceland,recoveredIceland)
plotData('Italy',popItaly,casesItaly,deathsItaly,recoveredItaly)
plotData('China',popChina,casesChina,deathsChina,recoveredChina)
% States of USA
plotData('Ohio',popOH,casesOH,deathsOH,recoveredOH)
plotData('Florida',popFL,casesFL,deathsFL,recoveredFL)
plotData('New York',popNY,casesNY,deathsNY,recoveredNY)


