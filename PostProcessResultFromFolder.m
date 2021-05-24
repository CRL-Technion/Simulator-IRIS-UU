close all
clear all

% folderDir = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\‏‏‏‏result_061120';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build\Results\‏‏Stop_Minus11_Intermediate_190521 - עותק';
% if ~exist('folderDir','var')
%     folderDir = 'C:\Users\david\OneDrive - Technion\Master\UAV_Simulation\Results\test_22012021';
% end
subFoldersNames = dir(folderDir);
numberOfRuns = length(subFoldersNames)-3;
runNumber = cell(numberOfRuns,1);

indexRuns=1;
tempIndex =1;
%     tempIndex = 1;
%     for i=1:1:length(subFoldersNames)-3
%      
%             temp = readtable([folderDir,'\',['Run',num2str(tempIndex)],'\OutputUAVsimulation.txt'],'ReadRowNames',true);
%             runNumber{tempIndex}.OutputUAVsimulation =temp(1:2:end,:);
%             temp = readtable([folderDir,'\',['Run',num2str(tempIndex)],'\OutputUAVsimulationMain.txt'],'ReadRowNames',true);
%             runNumber{tempIndex}.OutputUAVsimulationMain =temp(1:2:end,:);
%              tempIndex = tempIndex+1;
% 
%         end
% while (indexRuns<=numberOfRuns && tempIndex<numberOfRuns*length(subFoldersNames))
% while (indexRuns<=numberOfRuns )
minRunSolution = 4;
    tempIndex = tempIndex+1;
    for i=3:1:length(subFoldersNames)   
        if (strcmp(subFoldersNames(i).name,['Run',num2str(0)]))
          continue;
        end
        subFoldersNames(i).name
%         if (strcmp(subFoldersNames(i).name,['Run',num2str(indexRuns)]))
%         if(str2num(subFoldersNames(i).name(4))==10)
%         a=1;
%         end
            try
            temp = readtable([folderDir,'\',subFoldersNames(i).name,'\OutputUAVsimulation.txt'],'ReadRowNames',true);
            catch
                if (str2num(subFoldersNames(i).name(4:end))>minRunSolution)
                    minRunSolution = str2num(subFoldersNames(i).name(4:end));
                    minRunSolution
                end
                continue
            end
     
            runNumber{str2num(subFoldersNames(i).name(4:end))}.OutputUAVsimulation =temp(1:2:end,:);
%             clear 'temp';
            try
            temp = readtable([folderDir,'\',subFoldersNames(i).name,'\OutputUAVsimulationMain.txt'],'ReadRowNames',true);
             catch
                continue
            end
            runNumber{str2num(subFoldersNames(i).name(4:end))}.OutputUAVsimulationMain =temp(1:2:end,:);
%             clear 'temp';
          

%         end
    end
% end
runNumberTemp = cell(length(runNumber)-minRunSolution+1,1);
for i=1:1:length(runNumber)
    if (i==1)
    runNumberTemp{1} = runNumber{1};
    end
    if (i>minRunSolution)
        runNumberTemp{i-minRunSolution+1} = runNumber{i};
    end
end
clear runNumber;
runNumber =  runNumberTemp;   

for i =1:1:length(runNumber)
runNumber{i}.OutputUAVsimulationMain.Properties.VariableNames = runNumber{1}.OutputUAVsimulationMain.Properties.VariableNames;
end

labelesBoxPlot =cell(1,1);
for i =1:1:length(runNumber)
labelesBoxPlot{i} =num2str(runNumber{i}.OutputUAVsimulation.minTimeAllowInRiskZone(1));
end
% labelesBoxPlot{1} = 'Toy problem - Modify IRIS';
% labelesBoxPlot{2} = 'Toy problem - Original IRIS ';

    f1 = figure(1)
figure_name = 'figure1';
file_neme_figure = 'all_figure';
figure_path1 = fullfile(folderDir,figure_name);

hold on; box on; grid on;
title(' Total normalize location error')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
Total_normalize_location_error=zeros(length(runNumber{1}.OutputUAVsimulationMain.percentage_total_location_error),length(runNumber));
for i=1:1:length(runNumber)
    Total_normalize_location_error(:,i) = runNumber{i}.OutputUAVsimulationMain.percentage_total_location_error;
end


boxplot(Total_normalize_location_error,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel(' Total normalize location error[m]')

%   Save results
savefig(f1, figure_path1, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');
print(f1, figure_path1, '-dpdf');


f2 = figure(2)
figure_name = 'figure2';
figure_path2 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('Number of collision')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
Number_of_collision=zeros(length(runNumber{1}.OutputUAVsimulationMain.Number_of_collision),length(runNumber));
for i=1:1:length(runNumber)
    Number_of_collision(:,i) = runNumber{i}.OutputUAVsimulationMain.Number_of_collision;
end
boxplot(Number_of_collision,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel('Number of collision')
%   Save results
savefig(f2, figure_path2, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');
print(f2, figure_path2, '-dpdf');

f3 = figure(3)
figure_name = 'figure3';
figure_path3 = fullfile(folderDir,figure_name);
subplot(2,1,1)
hold on; box on; grid on;
title('percentageWCovRegion_POI')
% title('percentageWOUtVsWCovRegion_POI')

percentageWCovRegion_POI=zeros(length(runNumber{1}.OutputUAVsimulationMain.percentageWCovRegion_POI),length(runNumber));
for i=1:1:length(runNumber)
    percentageWCovRegion_POI(:,i) = runNumber{i}.OutputUAVsimulationMain.percentageWCovRegion_POI;
end
boxplot(percentageWCovRegion_POI,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel('percentageWCovRegion_POI')
ylim([0 100])
subplot(2,1,2)
hold on; box on; grid on;
title('percentageWOutagesRegion_POI')

percentageWOutagesRegion_POI=zeros(length(runNumber{1}.OutputUAVsimulationMain.percentageWOutagesRegion_POI),length(runNumber));
for i=1:1:length(runNumber)
    percentageWOutagesRegion_POI(:,i) = runNumber{i}.OutputUAVsimulationMain.percentageWOutagesRegion_POI;
end
boxplot(percentageWOutagesRegion_POI,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel('percentageWOutagesRegion_POI')
%   Save results
savefig(f3, figure_path3, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');
print(f3, figure_path3, '-dpdf');

f4 = figure(4)
figure_name = 'figure4';
figure_path4 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('percentageWOutVsWCovRegion_POI')

boxplot(percentageWOutagesRegion_POI./percentageWCovRegion_POI,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel('percentageWOutVsWCovRegion_POI')
%   Save results
savefig(f4, figure_path4, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');
print(f4, figure_path4, '-dpdf');

f5 = figure(5)
figure_name = 'figure5';
figure_path5 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('percentageOfPOI')
totalOptimalPOISimulation=zeros(length(runNumber{1}.OutputUAVsimulationMain.totalOptimalPOISimulation),length(runNumber));
totalOptimalPOIIRIS=zeros(length(runNumber{1}.OutputUAVsimulationMain.totalOptimalPOISimulation),length(runNumber));

for i=1:1:length(runNumber)
    totalOptimalPOISimulation(:,i) = runNumber{i}.OutputUAVsimulationMain.totalOptimalPOISimulation;%./runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS*100;
    totalOptimalPOIIRIS(:,i) = runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS;

end
percentageOfPOI=zeros(length(runNumber{1}.OutputUAVsimulationMain.percentageOfPOI),length(runNumber));
for i=1:1:length(runNumber)
    percentageOfPOI(:,i) = runNumber{i}.OutputUAVsimulationMain.percentageOfPOI;
end
% boxplot(percentageOfPOI,'Labels',labelesBoxPlot)
% boxplot(percentageOfPOI.*totalOptimalPOISimulation./totalOptimalPOIIRIS,'Labels',labelesBoxPlot)
boxplot(percentageOfPOI.*totalOptimalPOISimulation./totalOptimalPOIIRIS,'Labels',labelesBoxPlot)


xlabel('Max time allowed in risk zone')
ylabel('percentageOfPOI')
%   Save results
savefig(f5, figure_path5, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');


print(f5, figure_path5, '-dpdf');

f6 = figure(6)
figure_name = 'figure6';
figure_path6 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('percetageOptimal')


boxplot(totalOptimalPOISimulation./totalOptimalPOIIRIS,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel('percetageOptimal')
%   Save results
savefig(f6, figure_path6, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');


print(f6, figure_path6, '-dpdf');


f7 = figure(7)
figure_name = 'figure7';
figure_path7 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('Total length simulation')

Total_length_simulation=zeros(length(runNumber{1}.OutputUAVsimulation.Total_length_simulation),length(runNumber));
for i=1:1:length(runNumber)
    Total_length_simulation(:,i) = runNumber{i}.OutputUAVsimulation.Total_length_simulation;
end
boxplot(Total_length_simulation,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel('Total length simulation[m]')
%   Save results
savefig(f7, figure_path7, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');


print(f7, figure_path7, '-dpdf');


f8 = figure(8)
figure_name = 'figure8';
figure_path8 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('Total length planned')

Total_length_planned=zeros(length(runNumber{1}.OutputUAVsimulation.Total_length_planned),length(runNumber));
for i=1:1:length(runNumber)
    Total_length_planned(:,i) = runNumber{i}.OutputUAVsimulation.Total_length_planned;
end
boxplot(Total_length_planned,'Labels',labelesBoxPlot)
xlabel('Max time allowed in risk zone')
ylabel('Total length planned[m]')
%   Save results
savefig(f8, figure_path8, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');

print(f8, figure_path8, '-dpdf');

f9 = figure(9)
figure_name = 'figure9';
figure_path9 = fullfile(folderDir,figure_name);
% maxTimeAllowInRiskZone=zeros(length(runNumber{1}.OutputUAVsimulation.minTimeAllowInRiskZone),length(runNumber));
% for i=1:1:length(runNumber)
%     maxTimeAllowInRiskZone(:,i) = runNumber{i}.OutputUAVsimulation.minTimeAllowInRiskZone;
% end
maxTimeAllowInRiskZone=zeros(length(runNumber{1}.OutputUAVsimulation.maxTimeAllowInRiskZone),length(runNumber));
for i=1:1:length(runNumber)
    maxTimeAllowInRiskZone(:,i) = runNumber{i}.OutputUAVsimulation.maxTimeAllowInRiskZone;
end
meanMaxTimeAllowInRiskZone = mean(maxTimeAllowInRiskZone);
meanTotal_length_planned = mean(Total_length_planned);
meanTotal_length_simulation = mean(Total_length_simulation);
meanPercentageOfPOI = mean(percentageOfPOI.*totalOptimalPOISimulation./totalOptimalPOIIRIS);
meanTotal_normalize_location_error = mean(Total_normalize_location_error);

subplot(4,1,1)
hold on; box on; grid on;
title('Total length Vs. Max time allowd in risk zone')
% plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_planned(2:end),'LineWidth',2)
plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_planned(2:end),'LineWidth',2)
plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanTotal_length_planned(1),meanTotal_length_planned(1)],'LineWidth',2)

ylabel('Total length planned [m]')
xlabel('Max time allowed in risk zone [sec]')

subplot(4,1,2)
hold on; box on; grid on;
title('Total length Vs. Max time allowd in risk zone')
% plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_planned(2:end),'LineWidth',2)
plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_simulation(2:end),'LineWidth',2)
plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanTotal_length_simulation(1),meanTotal_length_simulation(1)],'LineWidth',2)

ylabel('Total length simulation [m]')
xlabel('Max time allowed in risk zone [sec]')

% legend('Total length simulation','Reference','location', 'best')
subplot(4,1,3)
hold on; box on; grid on;
title('POI inspected Vs. Max time allowd in risk zone')

plot(meanMaxTimeAllowInRiskZone(2:end),meanPercentageOfPOI(2:end),'LineWidth',2)
plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanPercentageOfPOI(1),meanPercentageOfPOI(1)],'LineWidth',2)

ylabel('POI inspected [%]')
xlabel('Max time allowed in risk zone [sec]')
% legend('POI inspected simulation','Reference','location', 'best')

subplot(4,1,4)
hold on; box on; grid on;
title('Total normalize location error Vs. Max time allowd in risk zone')
plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_normalize_location_error(2:end),'LineWidth',2)
plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanTotal_normalize_location_error(1),meanTotal_normalize_location_error(1)],'LineWidth',2)

ylabel('Total normalize location error')
xlabel('Max time allowed in risk zone [sec]')
% legend('Total normalize location error simulation','Reference','location', 'best')
% legend('Update','Reference','location', 'best')

%   Save results
savefig(f9, figure_path9, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');


print(f9, figure_path9, '-dpdf');

figure(10)
hold on; grid on; box on;
Scenarion = [meanMaxTimeAllowInRiskZone(2:end)];
lengthTemp = [meanTotal_length_simulation(2:end)];
POIInspectedTemp = [meanPercentageOfPOI(2:end)];

plotyy(Scenarion,lengthTemp,Scenarion,POIInspectedTemp)
xlabel('Max time allowed in risk zone [sec]')
ylabel('Total length [m]')
ylabel('POI inspected [%]')
%%

% close all
% figure(1)
% hold on; box on; grid on;
% title('Length GNSS Outages region Vs. PercentageOfPOI')
% % xlabel(' Length GNSS Outages region[%]')
% % ylabel('PercentageOfPOI[%]')
% methodFit = 'poly1';
% h1 = plot(dataOutputRef.percentageLocationError,dataOutputRef.percentageOfPOI,'*');
% f= fit(dataOutputRef.percentageLocationError,dataOutputRef.percentageOfPOI,methodFit);
% hfit1 = plot(f);hfit1.Color = h1.Color;hfit1.LineWidth = 2;
% h2 =plot(dataOutputTest_0.percentageLocationError,dataOutputTest_0.percentageOfPOI,'*');
% f= fit(dataOutputTest_0.percentageLocationError,dataOutputTest_0.percentageOfPOI,methodFit);
% hfit2 = plot(f);hfit2.Color = h2.Color;hfit2.LineWidth = 2;
% h3 =plot(dataOutputTest_5.percentageLocationError,dataOutputTest_5.percentageOfPOI,'*');
% f= fit(dataOutputTest_5.percentageLocationError,dataOutputTest_5.percentageOfPOI,methodFit);
% hfit3 = plot(f);hfit3.Color = h3.Color;hfit3.LineWidth = 2;
% h4 =plot(dataOutputTest_10.percentageLocationError,dataOutputTest_10.percentageOfPOI,'*');
% f= fit(dataOutputTest_10.percentageLocationError,dataOutputTest_10.percentageOfPOI,methodFit);
% hfit4 = plot(f);hfit4.Color = h4.Color;hfit4.LineWidth = 2;
% h5 =plot(dataOutputTest_15.percentageLocationError,dataOutputTest_15.percentageOfPOI,'*');
% f= fit(dataOutputTest_15.percentageLocationError,dataOutputTest_15.percentageOfPOI,methodFit);
% hfit5 = plot(f);hfit5.Color = h5.Color;hfit5.LineWidth = 2;
% % plot(dataOutputTest_20.percentageLocationError,dataOutputTest_20.percentageOfPOI,'*')
% xlabel(' Length GNSS Outages region[%]')
% ylabel('POI Inspected[%]')
% legend([h1,hfit1,h2,hfit2,h3,hfit3,h4,hfit4,h5,hfit5],labeles,'location','best')
%
%
% figure(2)
% hold on; box on; grid on;
% title(' Length GNSS Outages region Vs. Number of collision')
% % xlabel(' Length GNSS Outages region[%]')
% % ylabel('Number of collision')
% h1 = plot(dataOutputRef.percentageLocationError,dataOutputRef.Number_of_collision,'*');
% f= fit(dataOutputRef.percentageLocationError,dataOutputRef.Number_of_collision,methodFit);
% hfit1 = plot(f);hfit1.Color = h1.Color;hfit1.LineWidth = 2;
% h2 = plot(dataOutputTest_0.percentageLocationError,dataOutputTest_0.Number_of_collision,'*');
% f= fit(dataOutputTest_0.percentageLocationError,dataOutputTest_0.Number_of_collision,methodFit);
% hfit2 = plot(f);hfit2.Color = h2.Color;hfit2.LineWidth = 2;
% h3 = plot(dataOutputTest_5.percentageLocationError,dataOutputTest_5.Number_of_collision,'*');
% f= fit(dataOutputTest_5.percentageLocationError,dataOutputTest_5.Number_of_collision,methodFit);
% hfit3 = plot(f);hfit3.Color = h3.Color;hfit3.LineWidth = 2;
% h4 = plot(dataOutputTest_10.per centageLocationError,dataOutputTest_10.Number_of_collision,'*');
% f= fit(dataOutputTest_10.percentageLocationError,dataOutputTest_10.Number_of_collision,methodFit);
% hfit4 = plot(f);hfit4.Color = h4.Color;hfit4.LineWidth = 2;
% h5 = plot(dataOutputTest_15.percentageLocationError,dataOutputTest_15.Number_of_collision,'*');
% f= fit(dataOutputTest_15.percentageLocationError,dataOutputTest_15.Number_of_collision,methodFit);
% hfit5 = plot(f);hfit5.Color = h5.Color;hfit5.LineWidth = 2;
% % plot(dataOutputTest_20.percentageLocationError,dataOutputTest_20.Number_of_collision,'*')
% xlabel('Length GNSS Outages region[%]')
% ylabel('Number of collision')
%
% legend([h1,hfit1,h2,hfit2,h3,hfit3,h4,hfit4,h5,hfit5],labeles,'location','best')
