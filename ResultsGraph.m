close all
clear all
clc
%% 19102021 - Data small bridge  p = 1, eps =10, MCsimulation -10. ba = bg =10
Ref = [70.98,640.4,29710,777/1000];
Stop = [77,577,24579,638/1000];
Cost = [73,563,19609,618/1000];
MC = [77,760,49397,27066/1000;
    79,1027,572301,635415/1000;
    86,1163,1449990,2880883/1000;
    88,1308,5997080,22773494/1000;
    90,1460,8972440,46322552/1000];
Func = [90,2500,1406562,326368/1000];
TimesFunc = [92,1860,745857,94613/1000];

% Matrix = [Ref;Cost;Stop;MC;Func;TimesFunc];
Matrix = [Ref;Cost;Stop;MC];

figure
h=heatmap(Matrix);
h.ColorScaling = 'scaledcolumns';
% h.YDisplayLabels = {'REF','STOP','COST','MC1','MC2','MC3','MC4','MC5','FUNC','TimesFunc'}
h.YDisplayLabels = {'REF','STOP','COST','MC1','MC2','MC3','MC4','MC5'}

h.XDisplayLabels = {'POI [%]','Path length [m]','GeneratedNodes[#]','Search time [sec]'}
ax = gca
axp = struct(ax);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
colorbar off;
%%
%%POI
figure(1)
for index=1:1:3
    subplot(1,3,index)
    
    hold on; grid on; box on;
    plot(index,Ref(index),'*')
    plot(index,Stop(index),'*')
    plot(index,Cost(index),'*')
    for i=1:1:length(MC)
        plot(index,MC(i,index),'*')
    end
end
legend('REF','STOP','COST','MC1','MC2','MC3','MC4','MC5')
