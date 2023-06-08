close all
L =  1;
maxX = 14;
minX = 0;
x0 = (maxX-minX)/3;
x = minX:0.1:maxX;
k = 1;
y = 1-L./(1+exp(-k*(x-x0)));
figure(1)
box on; grid on;hold on

plot(x,y)
title('Sigmoid function of POI probability')
xlabel('Time in risk zone[sec]')
ylabel('POI probability[%]')
plot([x(1),x(end)],[0.99,0.99],'k','LineWidth',2)
plot([x(1),x(end)],[0.5,0.5],'k','LineWidth',2)

max(y)

%%
p = 0.4;
n = 10;
1-(1-p)^n>0.99
1,0.95,0.8,0.7,0.65,0.6,0.5,0.45,0.43,0.4