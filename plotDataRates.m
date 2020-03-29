function [] = plotDataRates(Name,pop,cases,deaths,recovered)
%--------------------------------------------------------------------------
% plotData.m
% 
% Description: This function plots the data from the covid19 project on a 
% logarithmic plot. The data is presented as a function of the total
% country's population.
%
% Author: Isaac Weintraub
%--------------------------------------------------------------------------
figure;
hold on
% H1=area(0:100,1000*ones(size(0:100)),'FaceColor',[1 0 0],...
%     'FaceAlpha',0.1,'EdgeColor','none');
% H1=area(0:100,100*ones(size(0:100)),'FaceColor',[1 1 1],...
%      'FaceAlpha',0.2,'EdgeColor','none');
% H1=area(0:100,10*ones(size(0:100)),'FaceColor',[1 1 1],...
%      'FaceAlpha',0.2,'EdgeColor','none');
% H1=area(0:100,1*ones(size(0:100)),'FaceColor',[1 1 1],...
%     'FaceAlpha',0.2,'EdgeColor','none');
text(2.5,1000,['1000 People/Day'])
text(2.5,100,['100 People/Day'])
text(2.5,10,['10 People/Day'])
text(2.5,1,['1 Person/Day'])
Dcases = diff(cases);
Ddeaths = diff(deaths);
Drecovered = diff(recovered);
% text(length(cases)+3,100*cases(end)./pop,['Cases: ' num2str(cases(end))])
% text(length(deaths)+3,100*deaths(end)./pop,['Deaths: ' num2str(deaths(end))])
p1 = semilogy(Dcases,'ko','DisplayName',[Name ' Confirmed Cases/Day'],'MarkerSize',8);
p2 = semilogy(Ddeaths,'ks','DisplayName',[Name ' Confirmed Deaths/Day'],'MarkerSize',8);
p3 = semilogy(Drecovered,'kp','DisplayName',[Name ' Confirmed Recoveries/Day'],'MarkerSize',10);
ffig = gcf;
ffig.Children.YScale = 'log';
legend([p1 p2 p3],'location','SouthEast')
xlim([0 100])
grid on
title(Name)
ylabel('Per Day Rates')
xlabel('Days Since Jan 22 2020')
end