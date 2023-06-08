clc
clear all
close all

% z = norminv(1-(1-0.9)/2);
p = 0:0.01:1;
n = 0:0.1:100;
[X,Y] = meshgrid(n,p);

figure(1)
CI = [0.1];

for i=1:1:length(CI)
% subplot(2,1,i)
hold on;grid on;box on;

contourf(X,Y,CLfromCI(CI(i),n,p))
colorbar
xlabel('#Samples')
ylabel('Probability')
title({'Confidence Level: Probability Vs. Samples', ['Confidence Interval = ',num2str(CI((i)))]})
end
% legend(cellLegend,'location','best')

%%
clc
clear all
close all

% z = norminv(1-(1-0.9)/2);
p = 0.5;
n = 0:0.01:500;
CI = 0.1;
[X,Y] = meshgrid(n,CI);

figure(1)
hold on;grid on;box on;
plot(n,CL,'linewidth',2)
xlabel('#Samples')
ylabel('Confidence Level')
title({'Confidence Level Vs. Samples', ['Probability = 0.5, CI = 0.1']})

CL = zeros(length(n),length(CI));
for i=1:1:length(CI)
CL(:,i) = CLfromCI(CI(i),n,p);


end
contourf(X,Y,CL')
% contourf(CL',Y,X)

colorbar
xlabel('#Samples')
ylabel('Confidence Interval')
title({'Confidence Level: Probability Vs. Samples', ['Probability = 0.5']})
caxis(0,1)
% xlabel('Confidence Level')
% ylabel('Confidence Interval')
% title({'#Samples : CI Vs. CL', ['Probability = 0.5']})
% xlim([0.4,1])


%%
IRIS_build_folder = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build'
CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];

confFile= importdata([IRIS_build_folder,'\testIRIS_conf']);
L_vertex = 100;%length(confFile);
costRiskZone = abs(floor(rand*5))+3

%%  Find "True" result
maxRun = 30;
seed = maxRun;
vertex_index = 48;floor(rand*L_vertex)
sampleNumber = 5000;
costRiskZone = 4;
system([CommandToPowershell,'./app/checkProbModel testIRIS_conf ',num2str(seed),' ',num2str(costRiskZone),' ',num2str(sampleNumber),' ',num2str(vertex_index),' checkProbFile']);
data = importdata([IRIS_build_folder,'\checkProbFile']);
%%

z = norminv(1-(1-0.9)/2);
p = normcdf([-z z]);
p(2)-p(1)
L = length(data(:,1));
p1 = sum(data(:,100))/L
sigma = std(data(:,100))
roots([1,-1,sigma^2])
trueResult = data(end,:);
RelevantePOIindex = find(trueResult>0);
L = sum(trueResult>0);
%%
data = trueResult(RelevantePOIindex)*0;

figure(1)
hold on;grid on;box on;
sampleNumberVec = 1;
accuracy =1;
error=1;
for seed=1:1:maxRun
% vertex_index = floor(rand*L_vertex)
sampleNumber = seed*10;
sampleNumberVec(seed) = sampleNumber;
system([CommandToPowershell,'./app/checkProbModel testIRIS_conf ',num2str(seed),' ',num2str(costRiskZone),' ',num2str(sampleNumber),' ',num2str(vertex_index),' checkProbFile']);
temp = importdata([IRIS_build_folder,'\checkProbFile']);

if (sum(sum(temp))<0.001 || isnan(sum(sum(temp))))
    continue;
end
data(seed,:) = temp(end,RelevantePOIindex);
accuracy(seed) = sum(abs(data(seed,:) -trueResult(RelevantePOIindex)));
% accuracy(seed) = 1-sum(abs(data(seed,RelevantePOIindex) -trueResult(RelevantePOIindex)))/L;
% 
%     y = accuracy;
% plot(y)
% drawnow

% plot(sampleNumberVec,accuracy)
% drawnow
end

plot(sampleNumberVec,accuracy,'LineWidth',2)
% plot(sampleNumberVec,error)

%%
% accuracy=1;%data;
% % accuracy(i) = 1- sqrt(i*data())
% % dataGaus = data(data>0.1 & data <0.9);
% %  = 
% [aa,bb] = find(data(end,:)>0);
% L = length(aa);
% temp=data(:,bb);
% for i=1:1:length(data(:,1))
%     temp(i,:) = 1-sqrt(data(i,bb).*(1-data(i,bb))/i);
%     accuracy(i,:) = sum(temp(i,:)/L);
%     
% end
% maxA = (max(accuracy))
% maxT = max(max(temp))
% trueResult = data(end,:);
% error_vec = abs(trueResult - data);
% y = sum(error_vec');

% y = smooth(abs(diff(data)));