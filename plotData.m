function [] = plotData (Name,pop,cases,deaths,recovered)
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
H1=area(0:100,100*ones(size(0:100)),'FaceColor',[1 0 0],...
    'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:100,10*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,1*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.1*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.01*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.0001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.00001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
text(2.5,160,['100% Pop: ' num2str(100*pop)])
text(2.5,15,['10% Pop: ' num2str(10*pop)])
text(2.5,01.5,['1% Pop: ' num2str(1*pop)])
text(2.5,0.15,['0.1% Pop: ' num2str(0.1*pop)])
text(2.5,0.015,['0.01% Pop: ' num2str(0.01*pop)])
text(length(cases)+3,100*cases(end)./pop,['Cases: ' num2str(cases(end))])
text(length(deaths)+3,100*deaths(end)./pop,['Deaths: ' num2str(deaths(end))])
p1 = semilogy(100*cases./pop,'ko','DisplayName',[Name ' Confirmed Cases'],'MarkerSize',8);
p2 = semilogy(100*deaths./pop,'ks','DisplayName',[Name ' Confirmed Deaths'],'MarkerSize',8);
p3 = semilogy(100*recovered./pop,'kp','DisplayName',[Name ' Confirmed Recovery'],'MarkerSize',10);
ffig = gcf;
ffig.Children.YScale = 'log';
legend([p1 p2 p3],'location','NorthEast')
xlim([0 100])
ylim([1e-6,1e2])
grid on
title(Name)
ylabel('Percent of total Population, %')
xlabel('Days Since Jan 22 2020')
end