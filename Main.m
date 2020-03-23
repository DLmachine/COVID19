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
popOhio = 11.69e6;
popSK = 51.47e6;
popItaly =  60.48e6;
popFr = 66.99e6;
popIran = 81.16e6;
popSpain = 46.66e6;
popIceland = 364260;
popChina = 1.386e9;
popNY = 8.623e6;

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

CountryShort = unique(Country);
ProvinceShort = unique(Province);

% USA
isUSA = strcmp(Country,'US'); 
%isUSA(200:end) = 0;      % Ignore minor outlaying islands
isUSA = isUSA(2:end);     % Remove the header
% Ohio
isOhio = strcmp(Province,'Ohio');
isOhio = isOhio(2:end);
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





index = 0;
for i = 3:size(cases.data,2)
    
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
    
    casesOhio(i-2)      = sum(cases.data(isOhio,i));
    deathsOhio(i-2)      = sum(deaths.data(isOhio,i));
    recoveredOhio(i-2)  = sum(recovered.data(isOhio,i));
    
    casesNY(i-2)      = sum(cases.data(isNY,i));
    deathsNY(i-2)      = sum(deaths.data(isNY,i));
    recoveredNY(i-2)  = sum(recovered.data(isNY,i));
    %casesChina(i-2) = sum(cases.data(isChina,i));
end

days = 1:length(casesUSA);


%-% DATA FITTING
% NY
fNY    = fit(days',casesNY','exp1');
fitNY  = @(x) fNY.a.*exp(fNY.b.*x);
fUSA   = fit(days(43:end)',casesUSA(43:end)','exp1');
fitUSA = @(x) fUSA.a.*exp(fUSA.b.*x);
%-% DATA PLOTTING


fig100 = figure(100);
hold on
H1=area(0:90,1.0*ones(size(0:90)),'FaceColor',[1 0 0],'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:90,0.10*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.01*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.00001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
text(2.5,1.6,['100% Pop: ' num2str(1.0*popUSA)])
text(2.5,0.15,['10% Pop: ' num2str(0.1*popUSA)])
text(2.5,0.015,['1% Pop: ' num2str(0.01*popUSA)])
text(2.5,0.0015,['0.1% Pop: ' num2str(0.001*popUSA)])
text(2.5,0.00015,['0.01% Pop: ' num2str(0.0001*popUSA)])
text(length(casesUSA)+3,casesUSA(end)./popUSA,['Cases: ' num2str(casesUSA(end))])
text(length(deathsUSA)+3,deathsUSA(end)./popUSA,['Deaths: ' num2str(deathsUSA(end))])
p1 = semilogy(casesUSA./popUSA,'ko','DisplayName','USA Confirmed Cases','MarkerSize',8);
p2 = semilogy(deathsUSA./popUSA,'ks','DisplayName','USA Confirmed Deaths','MarkerSize',8);
p3 = semilogy(recoveredUSA./popUSA,'kp','DisplayName','USA Confirmed Recovery','MarkerSize',10);
% semilogy(days+58,fitUSA(days),'r-','LineWidth',2)
semilogy(1:90,1e-8*exp(((1:90)-29.5).*0.29),'r-','LineWidth',2)
semilogy(1:90,1e-8*exp(((1:90)-39.5).*0.22),'r-','LineWidth',2)
fig100.Children.YScale = 'log';
legend([p1 p2 p3])
xlim([0 90])
ylim([1e-8,1])
grid on
title('United States of America')
ylabel('Percent of total Population, %')
xlabel('Days Since Jan 22 2020')

fig101 = figure(101)
hold on
DcasesUSA = diff(casesUSA);
DdeathsUSA = diff(deathsUSA);
DrecoveredUSA = diff(recoveredUSA);
semilogy([0 DcasesUSA(end)],[1e1, 1e1],'k-')
semilogy([0 DcasesUSA(end)],[1e2, 1e2],'k-')
semilogy([0 DcasesUSA(end)],[1e3, 1e3],'k-')
semilogy([0 DcasesUSA(end)],[1e4, 1e4],'k-')
p1 = semilogy(DcasesUSA,'ko','DisplayName','USA Confirmed Cases per Day','MarkerSize',8);
p2 = semilogy(DdeathsUSA,'ks','DisplayName','USA Confirmed Deaths per Day','MarkerSize',8);
p3 = semilogy(DrecoveredUSA,'kp','DisplayName','USA Confirmed Recovery per Day','MarkerSize',10);
fig101.Children.YScale = 'log';
text(2.5,1200,['1000 People/Day'])
text(2.5,120,['100 People/Day'])
text(2.5,12,['10 People/Day'])
legend([p1 p2 p3],'Location','NorthWest')
xlim([0 90])
grid on
title('United States of America')
ylabel('Rate of Change - Percent of total Population, %')
xlabel('Days Since Jan 22 2020')

%
fig200 = figure(200);
hold on
H1=area(0:90,1.0*ones(size(0:90)),'FaceColor',[1 0 0],'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:90,0.10*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.01*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.00001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
text(2.5,1.6,['100% Pop: ' num2str(1.0*popIceland)])
text(2.5,0.15,['10% Pop: ' num2str(0.1*popIceland)])
text(2.5,0.015,['1% Pop: ' num2str(0.01*popIceland)])
text(2.5,0.0015,['0.1% Pop: ' num2str(0.001*popIceland)])
text(2.5,0.00015,['0.01% Pop: ' num2str(0.0001*popIceland)])
text(length(casesIceland)+3,casesIceland(end)./popIceland,['Cases: ' num2str(casesIceland(end))])
text(length(deathsIceland)+3,deathsIceland(end)./popIceland,['Deaths: ' num2str(deathsIceland(end))])
p1 = semilogy(casesIceland./popIceland,'ko','DisplayName','Iceland Confirmed Cases','MarkerSize',8);
p2 = semilogy(deathsIceland./popIceland,'ks','DisplayName','Iceland Confirmed Deaths','MarkerSize',8);
p3 = semilogy(recoveredIceland./popIceland,'kp','DisplayName','Iceland Confirmed Recovery','MarkerSize',10);
fig200.Children.YScale = 'log';
legend([p1 p2 p3])
grid on
title('Iceland')
ylabel('Percent of total Population, %')
xlabel('Days Since Jan 22 2020')

fig300 = figure(300);
hold on
H1=area(0:90,1.0*ones(size(0:90)),'FaceColor',[1 0 0],'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:90,0.10*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.01*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.00001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
text(2,1.6,['100% Pop: ' num2str(1.0*popItaly)])
text(2,0.15,['10% Pop: ' num2str(0.1*popItaly)])
text(2,0.015,['1% Pop: ' num2str(0.01*popItaly)])
text(2,0.0015,['0.1% Pop: ' num2str(0.001*popItaly)])
text(2,0.00015,['0.01% Pop: ' num2str(0.0001*popItaly)])
text(length(casesItaly)+3,casesItaly(end)./popItaly,['Cases: ' num2str(casesItaly(end))])
text(length(deathsItaly)+3,deathsItaly(end)./popItaly,['Deaths: ' num2str(deathsItaly(end))])
p1 = semilogy(casesItaly./popItaly,'ko','DisplayName','Italy Confirmed Cases','MarkerSize',8);
p2 = semilogy(deathsItaly./popItaly,'ks','DisplayName','Italy Confirmed Deaths','MarkerSize',8);
p3 = semilogy(recoveredItaly./popItaly,'kp','DisplayName','Italy Confirmed Recovery','MarkerSize',10);
fig300.Children.YScale = 'log';
legend([p1 p2 p3])
grid on
title('Italy')
ylabel('Percent of total Population, %')
xlabel('Days Since Jan 22 2020')


%

fig400 = figure(400);
hold on
H1=area(0:90,1.0*ones(size(0:90)),'FaceColor',[1 0 0],'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:90,0.10*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.01*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.00001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
text(2,1.6,['100% Pop: ' num2str(1.0*popChina)])
text(2,0.15,['10% Pop: ' num2str(0.1*popChina)])
text(2,0.015,['1% Pop: ' num2str(0.01*popChina)])
text(2,0.0015,['0.1% Pop: ' num2str(0.001*popChina)])
text(2,0.00015,['0.01% Pop: ' num2str(0.0001*popChina)])
text(length(casesChina)+3,casesChina(end)./popChina,['Cases: ' num2str(casesChina(end))])
text(length(deathsChina)+3,deathsChina(end)./popChina,['Deaths: ' num2str(deathsChina(end))])
p1 = semilogy(casesChina./popChina,'ko','DisplayName','Iceland Confirmed Cases','MarkerSize',8);
p2 = semilogy(deathsChina./popChina,'ks','DisplayName','Iceland Confirmed Deaths','MarkerSize',8);
p3 = semilogy(recoveredChina./popChina,'kp','DisplayName','Iceland Confirmed Recovery','MarkerSize',10);
fig400.Children.YScale = 'log';
legend([p1 p2 p3])
grid on
title('China')
ylabel('Percent of total Population, %')
xlabel('Days Since Jan 22 2020')

%
fig500 = figure(500);
hold on
H1=area(0:90,1.0*ones(size(0:90)),'FaceColor',[1 0 0],'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:90,0.10*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.01*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.00001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
text(2,1.6,['100% Pop: ' num2str(1.0*popOhio)])
text(2,0.15,['10% Pop: ' num2str(0.1*popOhio)])
text(2,0.015,['1% Pop: ' num2str(0.01*popOhio)])
text(2,0.0015,['0.1% Pop: ' num2str(0.001*popOhio)])
text(2,0.00015,['0.01% Pop: ' num2str(0.0001*popOhio)])
text(length(casesOhio)+3,casesOhio(end)./popOhio,['Cases: ' num2str(casesOhio(end))])
text(length(deathsOhio)+3,deathsOhio(end)./popOhio,['Deaths: ' num2str(deathsOhio(end))])
p1 = semilogy(casesOhio./popOhio,'ko','DisplayName','Ohio Confirmed Cases','MarkerSize',8);
p2 = semilogy(deathsOhio./popOhio,'ks','DisplayName','Ohio Confirmed Deaths','MarkerSize',8);
p3 = semilogy(recoveredOhio./popOhio,'kp','DisplayName','Ohio Confirmed Recovery','MarkerSize',10);
fig500.Children.YScale = 'log';
legend([p1 p2 p3])
grid on
title('Ohio')
ylabel('Percent of total Population, %')
xlabel('Days Since Jan 22 2020')


fig600 = figure(600);
hold on
H1=area(0:90,1.0*ones(size(0:90)),'FaceColor',[1 0 0],'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:90,0.10*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.01*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.00001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:90,0.0000001*ones(size(0:90)),'FaceColor',[1 1 1],'FaceAlpha',0.2,'EdgeColor','none');
text(2,1.6,['100% Pop: ' num2str(1.0*popNY)])
text(2,0.15,['10% Pop: ' num2str(0.1*popNY)])
text(2,0.015,['1% Pop: ' num2str(0.01*popNY)])
text(2,0.0015,['0.1% Pop: ' num2str(0.001*popNY)])
text(2,0.00015,['0.01% Pop: ' num2str(0.0001*popNY)])
text(length(casesNY)+3,casesNY(end)./popNY,['Cases: ' num2str(casesNY(end))])
text(length(deathsNY)+3,deathsNY(end)./popNY,['Deaths: ' num2str(deathsNY(end))])
p1 = semilogy(casesNY./popNY,'ko','DisplayName','New York Confirmed Cases','MarkerSize',8);
p2 = semilogy(deathsNY./popNY,'ks','DisplayName','New York Confirmed Deaths','MarkerSize',8);
p3 = semilogy(recoveredNY./popNY,'kp','DisplayName','New York Confirmed Recovery','MarkerSize',10);
%p4 = semilogy(days+35,fitNY(days),'r-','LineWidth',2)
fig600.Children.YScale = 'log';
legend([p1 p2 p3])
grid on
title('New York')
ylabel('Percent of total Population, %')
xlabel('Days Since Jan 22 2020')
xlim([0 90])
ylim([1e-8 1])

