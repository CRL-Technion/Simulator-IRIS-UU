% close all
% clear all
addpath Command

% folderDir = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\‏‏‏‏result_061120';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_MC_simpleTest1_3_same';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_MC_simplifiedM_same';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\SimplifiedM_without_insert';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simplifiedM_with_insert1';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\FullMotionModel_sqrt3';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\FullMotionModel';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\FullMotionModel_05';


folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\SimpleScenario_1_3';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simpleScenario_1000mc';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_scenario_2m_100vertices';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\check_debug_160223';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simpleScenario_1000mc';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏simpleScenario_500mc';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridgeScenario_100mc';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏simple_500mc';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge100MC_95POI';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_100mc_100';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simple_500mc_newcoll';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simpleModel_100mc_valid';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simpleModel_brdige_100mc_valid';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simpleModel_brdige_100mc_097';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\BridgeModel_100mc_097';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\SimpleModel_500mc';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_SimpleModel_500mc';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_SimpleModel_500mc_05v';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge_SimpleModel_500mc_1v';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_SimpleModel_500mc_2v';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_SimpleModel_500mc_15v_test1';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge_SimpleModel_500mc_15v';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge_SimpleModel_500mc_1v_replan';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge_test_m_kappa';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simple_test_500_mc_replan';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge_simple_test_500_mc_replan';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_Bridge';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_Bridge_replan';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_Bridge__simple_500_20_search';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_Bridge__simple_50000';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_Bridge_simple_succesor_10000';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_simple_succesor_10000';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_simple_new_succesor_10000_';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_simple_10000_MC';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_bridge_simple_10000_MC';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_Bridge';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_simplify_100_MC';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏bridge_simplify_100_MC_test';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏bridge_simple_10000_MC';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏‏‏‏‏‏‏‏‏‏‏‏‏bridge_simple_10000_MC_test2';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏bridge_simple_full_100_MC_test';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏bridge_simplify_100_MC_test_4bias';

folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_simple_10000_MC_no_IPV';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\toy_simple_10000_MC_no_IPV_no_outages';



folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Toy_10000_mc';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Toy_10000_mc_no_IPV';

folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏Toy_10000_mc_combine';


folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏Bridge_simple_mc_combine';

folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏Bridge_simplify_mc_combine';

isCost = 0;
isMC=1;
testEps = 0;
CL = 0.95;


% if ~exist('folderDir','var')
%     folderDir = 'C:\Users\david\OneDrive - Technion\Master\UAV_Simulation\Results\test_22012021';
% end
subFoldersNames = dir(folderDir);
numberOfRuns = length(subFoldersNames)-3;
runNumber = cell(1,1);

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
minRunSolution = 1;
tempIndex = tempIndex+1;
for i=3:1:length(subFoldersNames)
    if (~strcmp(subFoldersNames(i).name(1:3),'Run'))
       continue;
    end
    if (strcmp(subFoldersNames(i).name,['Run',num2str(0)]))        
        continue;
    end
%     if(str2num(subFoldersNames(i).name(4:end))>24)
%         continue;
%     end
    %         if  (strcmp(subFoldersNames(i).name,['Run',num2str(indexRuns)]))
    %         if(str2num(subFoldersNames(i).name(4))==10)
    %         a=1;
    %         end
    try
        temp = readtable([folderDir,'\',subFoldersNames(i).name,'\OutputUAVsimulation.txt'],'ReadRowNames',true);
        runNumber{str2num(subFoldersNames(i).name(4:end))}.OutputUAVsimulation =temp(1:2:end,:);
    catch
      
    end
    
%     Command = InitCommand('testIRIS',[folderDir,'\',subFoldersNames(i).name,'\']);
%     runNumber{str2num(subFoldersNames(i).name(4:end))}.NumberOfVertexCommand =length(Command.Pose_des_GF);
%     
    %             clear 'temp';
    try
        temp = readtable([folderDir,'\',subFoldersNames(i).name,'\OutputUAVsimulationMain.txt'],'ReadRowNames',true);
        runNumber{str2num(subFoldersNames(i).name(4:end))}.OutputUAVsimulationMain =temp(1:2:end,:);
    catch
    end
    
    try
        temp = importdata([folderDir,'\',subFoldersNames(i).name,'\LocationErrorParameterFile']);
    catch
        continue
    end
    runNumber{str2num(subFoldersNames(i).name(4:end))}.MC_number =temp(end-1);
    
    try
        temp = importdata([folderDir,'\',subFoldersNames(i).name,'\testIRIS']);
    catch
        continue
    end
    runNumber{str2num(subFoldersNames(i).name(4:end))}.Nodes =sum(temp(end-2:end));%temp(end-5);%
    runNumber{str2num(subFoldersNames(i).name(4:end))}.SearchTime =(temp(end-5));%temp(end-5);%
    runNumber{str2num(subFoldersNames(i).name(4:end))}.POI_coverage =(temp(5));%temp(end-5);%
    runNumber{str2num(subFoldersNames(i).name(4:end))}.req_POI_coverage =temp(2);%(temp(2)*temp(3));%temp(end-5);%
    runNumber{str2num(subFoldersNames(i).name(4:end))}.ideal_POI_coverage =(temp(2));%temp(end-5);%

    a=1;
    
    
    try
temp = importdata([folderDir,'\',subFoldersNames(i).name,'\testIRIS_resultMC'],' ',2)   ; 
    catch
          if (str2num(subFoldersNames(i).name(4:end))>minRunSolution)
            minRunSolution = str2num(subFoldersNames(i).name(4:end));
        end
        continue
    end
    if (runNumber{str2num(subFoldersNames(i).name(4:end))}.MC_number)
    aa = str2num(temp.textdata{1});
    else
        aa = str2num(temp{1});
    end
%        tempVec =  reshape(temp, [length(temp(:,1))*length(temp(1,:)),1])
% tempA = temp';
% Indexes = [1:1:length(temp(:,1))*length(temp(1,:)),1];
% tempB = tempA(Indexes(~isnan(tempA)));
% tempB = tempB(length(temp(1,2:end))+3:end);
    runNumber{str2num(subFoldersNames(i).name(4:end))}.IPV = aa(2:end);%temp(1,2:end);
    if (runNumber{str2num(subFoldersNames(i).name(4:end))}.MC_number)
    runNumber{str2num(subFoldersNames(i).name(4:end))}.lengthVectorIRIS = temp.data;%bb(2:end)%tempB;1);
    else
        runNumber{str2num(subFoldersNames(i).name(4:end))}.lengthVectorIRIS =0;
    end
       try
%            continue
        temp = importdata([folderDir,'\',subFoldersNames(i).name,'\SimulationPath_testIRIS_MC']);
%         temp = importdata([folderDir,'\',subFoldersNames(i).name,'\testIRIS_MC']);
    catch
        continue
    end
    
    runNumber{str2num(subFoldersNames(i).name(4:end))}.POIsimulation = temp(:,1);
    runNumber{str2num(subFoldersNames(i).name(4:end))}.lengthVectorsimulation = temp(:,2);
    runNumber{str2num(subFoldersNames(i).name(4:end))}.NumberOfcollision= temp(:,3);
    runNumber{str2num(subFoldersNames(i).name(4:end))}.collisionVectorsimulation = temp(:,4:end);
    str2num(subFoldersNames(i).name(4:end))
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

% for i =1:1:length(runNumber)
%     runNumber{i}.OutputUAVsimulationMain.Properties.VariableNames = runNumber{1}.OutputUAVsimulationMain.Properties.VariableNames;
% end



labelesBoxPlot =cell(1,1);
for i =1:1:length(runNumber)
    if testEps
        labelesBoxPlot{i} =runNumber{i}.OutputUAVsimulation.initial_eps(1);
    else
        if isMC
            labelesBoxPlot{i} =num2str(runNumber{i}.MC_number);
        else
            if isCost
                labelesBoxPlot{i} =num2str(runNumber{i}.OutputUAVsimulation.minTimeAllowInRiskZone(1));
            else
                labelesBoxPlot{i} =num2str(runNumber{i}.OutputUAVsimulation.maxTimeAllowInRiskZone(1));
            end
        end
    end
end
% labelesBoxPlot{1} ='REF';
titleXlabel = 'Epsilon';
titleXlabel = '# Times for POI in risk zone ';
titleXlabel = 'Method';

% labelesBoxPlot{1} = 'Toy problem - Modify IRIS';
% labelesBoxPlot{2} = 'Toy problem - Original IRIS ';

% plotCI;
% plotCIOnlyIRISuu;
% PlotCINew;
PlotCINewCombine;
% PlotCIBaseLine;
return;


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
xlabel(titleXlabel)
ylabel(' Total normalize location error[m]')

%   Save results
savefig(f1, figure_path1, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');
print(f1, figure_path1, '-dpdf');


f2 = figure(2)
figure_name = 'figure2';
figure_path2 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('Percentage of collision')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
Number_of_collision=zeros(length(runNumber{1}.OutputUAVsimulationMain.Number_of_collision),length(runNumber));
bound_collision = zeros(length(runNumber{1}),2);
for i=1:1:length(runNumber)
    Number_of_collision(:,i) = runNumber{i}.OutputUAVsimulationMain.Number_of_collision/runNumber{i}.NumberOfVertexCommand*100;
    if(i>1)
        x =zeros(runNumber{i}.MC_number,1);
        pd = fitdist(x,'Binomial','NTrials',1)
        temp = paramci(pd,'Alpha',1-CL);
        bound_collision(i,1) = temp(1,2)* runNumber{i}.NumberOfVertexCommand;
        bound_collision(i,2) = temp(2,2)* runNumber{i}.NumberOfVertexCommand;
    end
end

boxplot(Number_of_collision,'Labels',labelesBoxPlot)
xlabel(titleXlabel)
ylabel('Percentage of collision[%]')
hold on;
bound_collision_num_max = -1;
for i=2:1:length(bound_collision)
    bound_collision_num = bound_collision(i,:)/runNumber{i}.NumberOfVertexCommand*100;
    if (bound_collision_num_max <bound_collision_num(1,2))
        bound_collision_num_max =bound_collision_num(1,2);
    end
    plot([i-0.25 i+0.25],[bound_collision_num(1,1) bound_collision_num(1,1)],'b','Linewidth',2)
    plot([i-0.25 i+0.25],[bound_collision_num(1,2) bound_collision_num(1,2)],'b','Linewidth',2)
    
end
ylim([0,bound_collision_num_max])

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
xlabel(titleXlabel)
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
xlabel(titleXlabel)
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
xlabel(titleXlabel)
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
bound_percetagePOI = zeros(length(runNumber{1}),2);
for i=1:1:length(runNumber)
    percentageOfPOI(:,i) = runNumber{i}.OutputUAVsimulationMain.percentageOfPOI;
    if(i>1)
        x =ones(runNumber{i}.MC_number,1);
        pd = fitdist(x,'Binomial','NTrials',1)
        temp = paramci(pd,'Alpha',1-CL);
        bound_POI(i,1) = temp(1,2)*runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS(1);
        bound_POI(i,2) = temp(2,2)*runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS(1);
    end
end

boxplot(percentageOfPOI,'Labels',labelesBoxPlot)
hold on;
bound_POI_num_min = 100;
for i=2:1:length(bound_POI)
    bound_POI_num = bound_POI(i,:)/runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS(1)*100;
    if (bound_POI_num_min> bound_POI_num(1,1))
        bound_POI_num_min= bound_POI_num(1,1);
    end
    plot([i-0.25 i+0.25],[bound_POI_num(1,1) bound_POI_num(1,1)],'b','Linewidth',2)
    plot([i-0.25 i+0.25],[bound_POI_num(1,2) bound_POI_num(1,2)],'b','Linewidth',2)
    
end
ylim([0 100])

xlabel(titleXlabel)
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
xlabel(titleXlabel)
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
xlabel(titleXlabel)
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
xlabel(titleXlabel)
ylabel('Total length planned[m]')
%   Save results
savefig(f8, figure_path8, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');

print(f8, figure_path8, '-dpdf');

f9 = figure(9)
figure_name = 'figure9';
figure_path9 = fullfile(folderDir,figure_name);
if (isCost)
    maxTimeAllowInRiskZone=zeros(length(runNumber{1}.OutputUAVsimulation.minTimeAllowInRiskZone),length(runNumber));
    for i=1:1:length(runNumber)
        maxTimeAllowInRiskZone(:,i) = runNumber{i}.OutputUAVsimulation.minTimeAllowInRiskZone;
    end
else
    if (isMC)
        maxTimeAllowInRiskZone=zeros(length(runNumber{1}.MC_number),length(runNumber));
        for i=1:1:length(runNumber)
            maxTimeAllowInRiskZone(:,i) = runNumber{i}.MC_number;
        end
    else
        maxTimeAllowInRiskZone=zeros(length(runNumber{1}.OutputUAVsimulation.maxTimeAllowInRiskZone),length(runNumber));
        for i=1:1:length(runNumber)
            maxTimeAllowInRiskZone(:,i) = runNumber{i}.OutputUAVsimulation.maxTimeAllowInRiskZone;
        end
    end
end
if isMC
    meanMaxTimeAllowInRiskZone = (maxTimeAllowInRiskZone);
else
    meanMaxTimeAllowInRiskZone = mean(maxTimeAllowInRiskZone);
end

if testEps
    meanMaxTimeAllowInRiskZone =  cell2mat(labelesBoxPlot);
end
meanTotal_length_planned = mean(Total_length_planned);
meanTotal_length_simulation = mean(Total_length_simulation);
% meanPercentageOfPOI = mean(percentageOfPOI.*totalOptimalPOISimulation./totalOptimalPOIIRIS);
meanPercentageOfPOI = mean(percentageOfPOI);

meanTotal_normalize_location_error = mean(Total_normalize_location_error);

% subplot(4,1,1)
% hold on; box on; grid on;
% title('Total length Vs. Max time allowd in risk zone')
% % plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_planned(2:end),'LineWidth',2)
% plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_planned(2:end),'LineWidth',2)
% plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanTotal_length_planned(1),meanTotal_length_planned(1)],'LineWidth',2)
%
% ylabel('Total length planned [m]')
% xlabel(titleXlabel)

subplot(3,1,1)
hold on; box on; grid on;
title('Total length')
% plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_planned(2:end),'LineWidth',2)
plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_length_simulation(2:end),'LineWidth',2)
plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanTotal_length_simulation(1),meanTotal_length_simulation(1)],'LineWidth',2)

ylabel('Total length simulation [m]')
xlabel(titleXlabel)

% legend('Total length simulation','Reference','location', 'best')
subplot(3,1,2)
hold on; box on; grid on;
title('POI inspected')

plot(meanMaxTimeAllowInRiskZone(2:end),meanPercentageOfPOI(2:end),'LineWidth',2)
plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanPercentageOfPOI(1),meanPercentageOfPOI(1)],'LineWidth',2)

ylabel('POI inspected [%]')
xlabel(titleXlabel)
% legend('POI inspected simulation','Reference','location', 'best')

subplot(3,1,3)
hold on; box on; grid on;
title('Total normalize location error')
plot(meanMaxTimeAllowInRiskZone(2:end),meanTotal_normalize_location_error(2:end),'LineWidth',2)
plot([meanMaxTimeAllowInRiskZone(2),meanMaxTimeAllowInRiskZone(end)],[meanTotal_normalize_location_error(1),meanTotal_normalize_location_error(1)],'LineWidth',2)

ylabel('Total normalize location error')
xlabel(titleXlabel)
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
xlabel(titleXlabel)
ylabel('Total length [m]')
ylabel('POI inspected [%]')
%%

f1 = figure(100)
figure_name = 'figure100';
file_neme_figure = 'all_figure';
figure_path100 = fullfile(folderDir,figure_name);

hold on; box on; grid on;
title('Generated Nodes')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
Nodes=zeros(length(runNumber{1}.Nodes),length(runNumber));
for i=1:1:length(runNumber)
    Nodes(:,i) = runNumber{i}.Nodes;
end
SearchTime=zeros(length(runNumber{1}.SearchTime),length(runNumber));
for i=1:1:length(runNumber)
    SearchTime(:,i) = runNumber{i}.SearchTime;
end
MC_number=zeros(length(runNumber{1}.MC_number),length(runNumber));
for i=1:1:length(runNumber)
    MC_number(:,i) = runNumber{i}.MC_number;
end
if ~isMC
    meanMaxTimeAllowInRiskZone(1) = -10
end
if testEps
    %     meanMaxTimeAllowInRiskZone(1) =100;% =  cell2mat(labelesBoxPlot);
end
minX = min(meanMaxTimeAllowInRiskZone(2:end));
maxX = max(meanMaxTimeAllowInRiskZone(2:end));

plot([minX,maxX],[Nodes(1),Nodes(1)],'LineWidth',2)
plot(meanMaxTimeAllowInRiskZone(2:end),Nodes(2:end),'LineWidth',2)
% boxplot(Nodes,'Labels',labelesBoxPlot)
legend('Ref','Cost method')
xlabel(titleXlabel)
ylabel('Generated Nodes')
set(gca, 'YScale', 'log')
%   Save results
savefig(f1, figure_path100, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f, bias_fig_path, '-dpdf', '-bestfit');
print(f1, figure_path100, '-dpdf');


%%
Matrix = [meanPercentageOfPOI',meanTotal_length_simulation',Nodes',SearchTime'/1000];

figure
h=heatmap(Matrix);
h.ColorScaling = 'scaledcolumns';
h.YDisplayLabels = {'REF','1:0.8','0.9:0.7','0.8:0.6','0.7:0.5'};%labelesBoxPlot;%
% h.YDisplayLabels = {'1','2','3','4','5','6','7','8','9','10'};
h.XDisplayLabels = {'POI [%]','Path length [m]','GeneratedNodes[#]','Search time [sec]'}
ax = gca
axp = struct(ax);       %you will get a warning
axp.Axes.XAxisLocation = 'top';
colorbar off
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
