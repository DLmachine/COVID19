function [] = plot2(Name,pop,cases,deaths,recovered)
%--------------------------------------------------------------------------
% plot2.m
% 
% Description: This function plots the data from the covid19 project on a 
% logarithmic plot. The data is presented as a function of the total
% country's population.
%
% Author: Isaac Weintraub
%--------------------------------------------------------------------------
figure;
hold on
H1=area(0:100,1*ones(size(0:100)),'FaceColor',[1 0 0],...
    'FaceAlpha',0.6,'EdgeColor','none');
H1=area(0:100,0.1*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,.01*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.0001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.00001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.000001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
H1=area(0:100,0.0000001*ones(size(0:100)),'FaceColor',[1 1 1],...
    'FaceAlpha',0.2,'EdgeColor','none');
text(2.5,1,['100% Pop: ' num2str(pop)])
text(2.5,0.16,['10% Pop: ' num2str(floor(0.1*pop))])
text(2.5,0.016,['1% Pop: ' num2str(floor(0.01*pop))])
text(2.5,0.0016,['0.1% Pop: ' num2str(floor(0.001*pop))])
text(2.5,0.00016,['0.01% Pop: ' num2str(floor(0.0001*pop))])
text(length(cases)+3,cases(end)./pop,['Cases: ' num2str(cases(end))])
text(length(deaths)+3,deaths(end)./pop,['Deaths: ' num2str(deaths(end))])
p1 = semilogy(cases./pop,'ko','DisplayName',[Name ' Confirmed Cases'],'MarkerSize',8);
p2 = semilogy(deaths./pop,'ks','DisplayName',[Name ' Confirmed Deaths'],'MarkerSize',8);
p3 = semilogy(recovered./pop,'kp','DisplayName',[Name ' Confirmed Recovery'],'MarkerSize',10);
ffig = gcf;
ffig.Children.YScale = 'log';
legend([p1 p2 p3],'location','NorthEast')
xlim([0 100])
ylim([1e-8,1])
grid on
title(Name)
ylabel('Fraction of total Population')
xlabel('Days Since Jan 22 2020')

figure;
hold on
p1 = semilogy(cases,'ko','DisplayName',[Name ' Confirmed Cases'],'MarkerSize',8);
p2 = semilogy(deaths,'ks','DisplayName',[Name ' Confirmed Deaths'],'MarkerSize',8);
p3 = semilogy(recovered,'kp','DisplayName',[Name ' Confirmed Recovery'],'MarkerSize',10);
ffig = gcf;
ffig.Children.YScale = 'linear';
legend([p1 p2 p3],'location','NorthEast')
xlim([0 100])
grid on
title(Name)
ylabel('Number of Confirmed Cases')
xlabel('Days Since Jan 22 2020')

fig3 = figure;
hold on
Dcases = filter(-smooth_diff(10),1,cases);
%Dcases = diff(cases);
Ddeaths = diff(deaths);
Drecovered = diff(recovered);
plot(cases,Dcases,'k-o','DisplayName',[Name ' Confirmed Cases'],'MarkerSize',8);
legend([p1],'location','NorthWest')
grid on
fig3.Children.XScale = 'log';
fig3.Children.YScale = 'log';
title(Name)
ylabel('Rate Change of Cases')
xlabel('Number of Confirmed Cases')

fig4 = figure;
hold on
Dcases  = filter(-smooth_diff(10),1,cases);
DDcases = filter(-smooth_diff(10),1,Dcases);
%Dcases = diff(cases);
Ddeaths = diff(deaths);
Drecovered = diff(recovered);
plot(Dcases,DDcases,'-o','DisplayName',[Name ' Confirmed Cases'],'MarkerSize',8);
legend([p1],'location','NorthWest')
grid on
fig4.Children.XScale = 'linear';
fig4.Children.YScale = 'linear';
title(Name)
ylabel('Acceleration of Confirmed Cases')
xlabel('Rate of Confirmed Cases')


end