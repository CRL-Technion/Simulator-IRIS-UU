addpath Command
addpath violinPlot
includeRef=0;
labelesBoxPlotOriginal = labelesBoxPlot;
labelesBoxPlot{1} = 'IRIS';
labelesBoxPlot{2} = 'IRIS-MLU';
for i=3:1:length(labelesBoxPlot)
    labelesBoxPlot{i} = ['IRIS-U^2-',labelesBoxPlot{i}];
end
close all
CL = 0.95;
alpha = 1-CL;
%%
% f5 = figure(98)
%subplot(2,2,1)
f = figure(1);
f.Position = [100 100 700 200];
% set(gca, 'YScale', 'log')
% yticks([40:20:100])
figure_name = 'CI';
figure_path5 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
% set(gca, 'YScale', 'log')
% yticks([0.1,0.5 1 5 10,20,50,70,80,90,95,100])
% title('Percentage of POI')
% totalOptimalPOISimulation=zeros(length(runNumber{1}.OutputUAVsimulationMain.totalOptimalPOISimulation),length(runNumber));
% totalOptimalPOIIRIS=zeros(length(runNumber{1}.OutputUAVsimulationMain.totalOptimalPOISimulation),length(runNumber));
%
% for i=1:1:length(runNumber)
%     totalOptimalPOISimulation(:,i) = runNumber{i}.OutputUAVsimulationMain.totalOptimalPOISimulation;%./runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS*100;
%     totalOptimalPOIIRIS(:,i) = runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS;
%
% end
% percentageOfPOI=zeros(length(runNumber{1}.OutputUAVsimulationMain.percentageOfPOI),length(runNumber));
percentageOfPOI = zeros(length(runNumber{i}.POIsimulation),1);
bound_percetagePOI = zeros(1,2);
for i=1:1:length(runNumber)
    bound_percetagePOI_individual = zeros(1,2);
    y=0;
    %     percentageOfPOI(:,i) = runNumber{i}.OutputUAVsimulationMain.percentageOfPOI;
%     percentageOfPOI(:,i) = 100*(runNumber{i}.POIsimulation)/20;%sum(runNumber{i}.IPV);
    percentageOfPOI(:,i) = 100*(runNumber{i}.POIsimulation)/(runNumber{i}.req_POI_coverage);

    counterNotRelevantPOI = 0;
    counterRelevantPOI = 0;
    if(runNumber{i}.MC_number>1)
        for j=1:1:length(runNumber{i}.IPV)
            if (runNumber{i}.IPV(j)<0.001)
                counterNotRelevantPOI = counterNotRelevantPOI+1;
                continue
            end
            counterRelevantPOI = counterRelevantPOI+1;
            x =ones(runNumber{i}.MC_number,1)*runNumber{i}.IPV(j);
            [phat,pci] = binofit(sum(x),length(x),alpha);
            temp(1,2) = pci(1);
            temp(2,2) = pci(2);
            if (j>1)
                bound_percetagePOI_individual(1,1) = bound_percetagePOI_individual(1,1) + temp(1,2);
                bound_percetagePOI_individual(1,2) = bound_percetagePOI_individual(1,2) + temp(2,2);
            else
                bound_percetagePOI_individual(1,1) =  temp(1,2);
                bound_percetagePOI_individual(1,2) =  temp(2,2);
            end
        end
        if (counterRelevantPOI<runNumber{i}.req_POI_coverage)
            [phat,pci] = binofit(0,runNumber{i}.MC_number,alpha);
            temp(1,2) = pci(1)*(runNumber{i}.req_POI_coverage-counterRelevantPOI);
            temp(2,2) = pci(2)*(runNumber{i}.req_POI_coverage-counterRelevantPOI);
            bound_percetagePOI_individual(1,1) = bound_percetagePOI_individual(1,1) + temp(1,2);
            bound_percetagePOI_individual(1,2) = bound_percetagePOI_individual(1,2) + temp(2,2);
        end
        bound_percetagePOI(i,:) = bound_percetagePOI_individual(1,:)/sum(runNumber{i}.req_POI_coverage);
    end
end
violinPlot(percentageOfPOI,'addSpread',1.1,'xNames',labelesBoxPlot,'showMM',2)
% boxplot(percentageOfPOI,'Labels',labelesBoxPlot)
hold on;
bound_POI_num_min = 100;
for i=1:1:length(bound_percetagePOI(:,1))
    if(runNumber{i}.MC_number>1)
        
        %         bound_POI_num = bound_percetagePOI(i,:)/length(runNumber{i}.IPV)*100;
        bound_POI_num = bound_percetagePOI(i,:)*100;
        
        if (bound_POI_num_min> bound_POI_num(1,1))
            bound_POI_num_min= bound_POI_num(1,1);
        end
        h1 =  plot([i-0.25 i+0.25],[bound_POI_num(1,1) bound_POI_num(1,1)],'r','Linewidth',2);
        plot([i-0.25 i+0.25],[bound_POI_num(1,2) bound_POI_num(1,2)],'r','Linewidth',2)
    end
end
ylim([39 100])

xlabel('$m$','fontsize',12,'fontsize',12,'Interpreter','latex')
ylabel('Percentage of POI [%]','fontsize',12)
legend(h1,'CI for mean','location','best')
% savefig(f5, figure_path5, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f5, figure_path5, '-dpdf');

%%
%subplot(2,2,2)
f = figure(2);
f.Position = [100 100 700 200];
hold on; box on; grid on;
% set(gca, 'YScale', 'log')
% yticks([0.1,0.5 1 5 10,20,50])
% title('Collision probability')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
% Number_of_collision = 0;%=zeros(length(runNumber{1}.OutputUAVsimulationMain.Number_of_collision),length(runNumber));
bound_collision = zeros(length(runNumber{1}),2);
bound_collision_simulation = zeros(length(runNumber{1}),2);


collisionProbability1 = 1;
    subNumberOfcollision = 1;
collisionProbability = 1;
for i=1:1:length(runNumber)
    collisionProbabilityAllEdges = mean(runNumber{i}.collisionVectorsimulation(:,2:end));
        collisionProbability(i) = 1;
        for j=1:1:length(collisionProbabilityAllEdges)
            collisionProbability(i) = collisionProbability(i)*(1-collisionProbabilityAllEdges(j));
        end
        collisionProbability(i) = 1-collisionProbability(i);
%     Number_of_collision(:,i) = runNumber{i}.NumberOfcollision;
%     if (i==1)
%         Number_of_collision(:,i)=Number_of_collision(:,i)/8;
%     else
%         Number_of_collision(:,i)=Number_of_collision(:,i)/(length(runNumber{i}.lengthVectorIRIS(:,1))-1);
%     end
    
    Number_of_collision(:,i) = runNumber{i}.NumberOfcollision;
    tempArray = 1:1:length(Number_of_collision(:,i));
    indexTemp = Number_of_collision(:,i)>0.5;
    Number_of_collision(tempArray(Number_of_collision(:,i)>0.5),i) = 1;
    index = 0;
    k=1;
    while(k<length(Number_of_collision))
        index = index+1;
        subNumberOfcollision(i,index)= mean(Number_of_collision(k:k+49,i));
        k=k+50;
    end
    if(runNumber{i}.MC_number>1)

        x =zeros(runNumber{i}.MC_number,1);
        [phat,pci] = binofit(sum(x),length(x),alpha);
(length(runNumber{i}.lengthVectorIRIS(:,1))-1)
        temp(1,2) = pci(1);
        temp(2,2) = pci(2);
        bound_collision(i,1) = temp(1,2);
        bound_collision(i,2) = temp(2,2);

    end
    
    
end
% boxplot(Number_of_collision,'Labels',labelesBoxPlot)
violinPlot(Number_of_collision,'addSpread',1.1,'xNames',labelesBoxPlot,'showMM',2)
% violinPlot(Number_of_collision,'xNames',labelesBoxPlot,'showMM',2)
% boxplot(Number_of_collision,'Labels',labelesBoxPlot)
% violinplot(Number_of_collision,labelesBoxPlot)

xlabel('$m$','fontsize',12,'fontsize',12,'Interpreter','latex')
ylabel('Collision probability','fontsize',12)
hold on;


bound_collision_num_max = -1;

for i=1:1:length(bound_collision(:,1))
    if(runNumber{i}.MC_number>1)
        
        bound_collision_num = bound_collision(i,:);
        if (bound_collision_num_max< bound_collision_num(1,2))
            bound_collision_num_max= bound_collision_num(1,2);
        end
        h1 = plot([i-0.25 i+0.25],[bound_collision_num(1,1) bound_collision_num(1,1)],'r','Linewidth',2);
        plot([i-0.25 i+0.25],[bound_collision_num(1,2) bound_collision_num(1,2)],'r','Linewidth',2);
    end
            plot(i,collisionProbability(i),'o','Linewidth',2);
%             plot(i*ones(length(collisionProbability)),collisionProbability(i,:),'o','Linewidth',2);
            plot(i*ones(length(subNumberOfcollision(i,:)),1),subNumberOfcollision(i,:),'o','Linewidth',2);


end
% if (bound_collision_num_max > 50)
%     bound_collision_num_max = 50;
% end
ylim([0,1])
% ylim([0,40])

legend(h1,'CI for mean','location','best')
% savefig(f2, figure_path2, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f2, figure_path2, '-dpdf');



%%
%subplot(2,2,3)
% close all
f = figure(3);
f.Position = [100 100 700 200];
% set(gca, 'YScale', 'log')
% yticks([200:200:1200])
hold on; box on; grid on;
% title('Execution path length')
temp = 0;
% Total_length_simulation=zeros(length(runNumber{i}.OutputUAVsimulation.Total_length_simulation),length(runNumber));
Total_length_simulation = runNumber{1}.lengthVectorsimulation;
Total_length_IRIS = cell(1,1);
for i=1:1:length(runNumber)
    Total_length_simulation(:,i) = runNumber{i}.lengthVectorsimulation;
    %     if (i>1)
    Total_length_IRIS{i} = runNumber{i}.lengthVectorIRIS(1,:)';
    %     end
end
% boxplot(Total_length_simulation,'Labels',labelesBoxPlot)
violinPlot(Total_length_simulation,'addSpread',1.1,'xNames',labelesBoxPlot,'showMM',2)
% violinPlot(Total_length_IRIS,'showMM',3)

xlabel('$m$','fontsize',12,'fontsize',12,'Interpreter','latex')
ylabel('Path length [m]','fontsize',12)
%   Save results

bound_length_individual = zeros(1,2);
bound_length = zeros(1,2);
bound_length_mean = zeros(1,2);
temp_lower = [0,0];
for i=1:1:length(runNumber)
    %         x =Total_length_planned(:,i);
    %     i
    %     runNumber{i}.MC_number
    
    if(runNumber{i}.MC_number>1)
        xraw = runNumber{i}.lengthVectorIRIS;
        %         x = [-diff(xraw)];
        %         meanTotalLength = 0;
        %         SD=0;
        %         for j=1:1:length(x(:,1))
        %
        %             %             if(runNumber{i}.MC_number>30)
        %             %                 pd = fitdist(x(j,:)','Normal');
        %             %             else
        %             %                 pd = fitdist(x(j,:)','Poisson');
        %             %             end
        %             %             %             pd = fitdist(x(j,:)','Normal');
        %             %
        %             %             %             pd = fitdist(x(j,:)','Normal');
        %             %             pd = fitdist(x(j,:)','Normal');
        %             %             %             pd = fitdist(x(j,:)','Normal');
        %             %             temp = paramci(pd,'Alpha',1-CL);
        %
        %             x_current = x(j,:)';
        %             SEM = std(x_current)/sqrt(length(x_current));
        %             [h,p,ci,stats] = ttest((x_current-mean(x_current))/(std(x_current)/sqrt(length(x_current))),0,'Alpha',0.05);
        %
        %             temp(1:2) = mean(x_current)+ci*SEM;
        %             [phat,pci] = mle(x_current,'distribution','Normal','alpha',.05);
        %
        %
        %
        %
        % %              alpha = 0.05;
        % %             N = length(x_current);
        % %             UpperlimitStd =SD*sqrt((N-1)/chi2inv((alpha/2), N-1));
        % %             LowerlimitStd =SD*sqrt((N-1)/chi2inv(1-(alpha/2), N-1));
        % %
        % %
        % %             temp(1) = pci(1,1)-3*UpperlimitStd;
        % %             temp(2) = pci(2,1)+3*UpperlimitStd;
        % %
        % %
        % %             if (j>1)
        % %                 bound_length_individual(1) = bound_length_individual(1) + temp(1);
        % %                 bound_length_individual(2) = bound_length_individual(2) + temp(2);
        % %                 temp_lower(1) =temp_lower(1)+ pci(1,1)-3*LowerlimitStd;
        % %                 temp_lower(2) = temp_lower(2)+pci(2,1)+3*LowerlimitStd;
        % %             else
        % %                 bound_length_individual(1) =  temp(1);
        % %                 bound_length_individual(2) =  temp(2);
        % %                 temp_lower(1) = pci(1,1)-3*LowerlimitStd;
        % %                 temp_lower(2) = pci(2,1)+3*LowerlimitStd;
        % %             end
        % %                 x_current = x(j,:)';
        % %             SD = SD + std(x_current)^2;
        % %             meanTotalLength = meanTotalLength + mean(x_current);
        %         end
        %
        %         bound_length(i,:) = bound_length_individual(1,:);
        %         if (bound_length(i,1)<0)
        %             bound_length(i,1) = 0;
        %         end
        %         bound_length_lower(i,:) = temp_lower(1,:);
        %         if (bound_length_lower(i,1)<0)
        %             bound_length_lower(i,1) = 0;
        %         end
        
        %         x_current = xraw(1,:);
        %         mean(runNumber{i}.lengthVectorsimulation)
        %         interval=ciFunc(x_current,95);
        %         ci(1) = -interval;
        %         ci(2) = interval;
        %         SD1 = std(x_current);
        %         alpha = 0.05;
        %         N = length(x_current);
        %         UpperlimitStd =SD1*sqrt((N-1)/chi2inv((alpha/2), N-1));
        %
        %         %             LowerlimitStd =SD1*sqrt((N-1)/chi2inv(1-(alpha/2), N-1));
        %         %             UpperlimitStd = LowerlimitStd;
        %         %             UpperlimitStd=0;
        %         %             temp(1:2) = mean(x_current)+ci;
        %         %               temp(1) = temp(1)-3*UpperlimitStd;
        %         %             temp(2) = temp(2) +3*UpperlimitStd;
        %
        %         x_current = xraw(1,:);
        %         numgroups=5;
        %         numOfElementsInEachGroup = length(x_current)/5;
        %         x_groups = reshape(x_current,[5,numOfElementsInEachGroup]);
        %
        %
        %         temp(1:2) = mean(mean(x_groups'));
        %         SD1 = mean(std(x_groups'));
        %         % SD1 = mean(std(x_current(1:L_half))+std(x_current(L_half+1:end)));
        %         A1 = TABLEA28(numOfElementsInEachGroup);
        %
        %         temp(1) = temp(1)-A1*SD1;
        %         temp(2) = temp(2) +A1*SD1;
        
        x_current = xraw(1,:);
        interval=ciFunc(x_current,95);
        ci(1) = -interval;
        ci(2) = interval;
        temp(1:2) = mean(x_current)+ci;
        bound_length_mean(i,:) = temp;
        
        x_current = xraw(1,:);
        alpha = 0.05;
        N = length(x_current);
        SD1 = std(x_current);
        UpperlimitStd =SD1*sqrt((N-1)/chi2inv((alpha/2), N-1));
        %                     LowerlimitStd =SD1*sqrt((N-1)/chi2inv(1-(alpha/2), N-1));
        
        temp(1) = temp(1)-3*UpperlimitStd;
        temp(2) = temp(2) +3*UpperlimitStd;
        bound_length(i,:) =  temp;
        
        
        %                 temp(1) = mean(x_current)-3*sqrt(length(xraw)*SD^2)/sqrt(N);
        %             temp(2) = mean(x_current)+3*sqrt(length(xraw)*SD^2)/sqrt(N);
        %
        %
        
        
        %             LowerlimitStd =SD*sqrt((N-1)/chi2inv(1-(alpha/2), N-1));
        % %             LowerlimitStd=0;
        %             temp(1:2) = mean(x_current)+ci;
        %               temp(1) = temp(1)-3*LowerlimitStd;
        %             temp(2) = temp(2) +3*LowerlimitStd;
        %          bound_length_lower(i,:) =  temp;
        %          alphaup = 1-0.05/2;
        %     t = tinv(alphaup,length(x(:,1))*(runNumber{i}.MC_number-1));
        %
        %                         x_current = xraw(1,:);
        %             SD = std(x_current)^2;
        %             meanTotalLength =  mean(x_current);
        %
        %     bound_length(i,1) =meanTotalLength - t *sqrt(SD)/sqrt(runNumber{i}.MC_number);
        %         bound_length(i,2) =meanTotalLength + t *sqrt(SD)/sqrt(runNumber{i}.MC_number);
        
        %    bound_length(i,1) =meanTotalLength - 3 *sqrt(SD)/sqrt(runNumber{i}.MC_number);
        %         bound_length(i,2) =meanTotalLength + 3 *sqrt(SD)/sqrt(runNumber{i}.MC_number);
        
    end
    
    
    
    
    
    
    
    %
    %     x = runNumber{i}.lengthVectorIRIS';
    %     if(runNumber{i}.MC_number>1)
    %
    %             pd = fitdist(x,'Poisson')
    % %         pd = fitdist(x,'Normal')
    %         temp = paramci(pd,'Alpha',1-CL);
    %         bound_length(i,1) = temp(1);
    %         bound_length(i,2) = temp(2);
    %     end
end

for i=1:1:length(bound_length(:,1))
    if(runNumber{i}.MC_number>1)
        
        
        %         bound_length_num = bound_length_lower(i,:);
        %         h1=plot([i-0.25 i+0.25],[bound_length_num(1) bound_length_num(1)],'r','Linewidth',2);
        %         plot([i-0.25 i+0.25],[bound_length_num(2) bound_length_num(2)],'r','Linewidth',2);
        %
        bound_length_num = bound_length(i,:);
        h1=plot([i-0.25 i+0.25],[bound_length_num(1) bound_length_num(1)],'b','Linewidth',2);
        plot([i-0.25 i+0.25],[bound_length_num(2) bound_length_num(2)],'b','Linewidth',2);
        
        bound_length_num = bound_length_mean(i,:);
        h2=plot([i-0.25 i+0.25],[bound_length_num(1) bound_length_num(1)],'r','Linewidth',2);
        plot([i-0.25 i+0.25],[bound_length_num(2) bound_length_num(2)],'r','Linewidth',2);
        
        
    end
end
% ylim([min(min([bound_length,Total_length_simulation'])) max(max([bound_length,Total_length_simulation']))])
legend([h1,h2],'CI for 3\sigma','CI for mean','location','best')

% size(temp(Total_length_simulation > bound_length(1) & Total_length_simulation < bound_length(2)))
%%

%subplot(2,2,4)
titleXlabel = 'm';
f = figure(4);
f.Position = [100 100 700 200];
hold on; box on; grid on;
% title('execution path length')
RunNumberVec = 0;
SearchTimeVec = 0;
for i=1:1:length(runNumber)
    if(i<2)
        RunNumberVec(i) = runNumber{i}.MC_number;
        SearchTimeVec(i) = runNumber{i}.SearchTime/1000;
    else
        RunNumberVec(i) = runNumber{i}.MC_number;
        SearchTimeVec(i) = runNumber{i}.SearchTime/1000;
    end
    
end
plot(RunNumberVec,(SearchTimeVec),'b','Linewidth',3)
% title('Search Time')
xlabel('$m$','fontsize',12,'fontsize',12,'Interpreter','latex')
ylabel(' Search Time [s]','fontsize',12)
set(gca, 'YScale', 'log')
yticks([2,5 50 100 500 1000 5000 10000])
ylim([min((SearchTimeVec)),max(SearchTimeVec)+1])

ax = gca;
ax.XAxis.TickLabels = labelesBoxPlotOriginal;
ax.XAxis.TickLabels{1} = '0';
ax.XAxis.TickValues = 0;
tickValuesTemp = str2num(ax.XAxis.TickLabels{1});
tickLabelTemp =cell(1,1);
tickLabelTemp{1} = ax.XAxis.TickLabels{1};
for i=2:1:length(ax.XAxis.TickLabels)
    tickValuesTemp(i-1) = str2num(ax.XAxis.TickLabels{i});
    tickLabelTemp{i-1} = ax.XAxis.TickLabels{i};
end
ax.XAxis.TickValues = tickValuesTemp;
ax.XAxis.TickLabels = tickLabelTemp;

% ax.XAxis.TickValues = [min(ax.XAxis.TickValues):min(diff(ax.XAxis.TickValues)):max(ax.XAxis.TickValues)];
tickLabelTemp{1} = 'IRIS';
ax.XAxis.TickLabels = tickLabelTemp;

% savefig(f5, figure_path5, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f5, figure_path5, '-dpdf');
temp = [1:1:length(Total_length_simulation)];