addpath Command
addpath violinPlot
includeRef=1;
runNumberTemp = cell(1,1);
labelesBoxPlotTemp = cell(1,1);
if (includeRef==0)
    for i=2:1:length(runNumber)
        runNumberTemp{i-1} = runNumber{i};
        labelesBoxPlotTemp{i-1} = labelesBoxPlot{i};
    end
end
labelesBoxPlot = labelesBoxPlotTemp;
runNumber = runNumberTemp;

close all
f5 = figure(98)
subplot(2,2,1)
% figure(1)
figure_name = 'CI';
figure_path5 = fullfile(folderDir,figure_name);
hold on; box on; grid on;
title('Percentage of POI')
% totalOptimalPOISimulation=zeros(length(runNumber{1}.OutputUAVsimulationMain.totalOptimalPOISimulation),length(runNumber));
% totalOptimalPOIIRIS=zeros(length(runNumber{1}.OutputUAVsimulationMain.totalOptimalPOISimulation),length(runNumber));
%
% for i=1:1:length(runNumber)
%     totalOptimalPOISimulation(:,i) = runNumber{i}.OutputUAVsimulationMain.totalOptimalPOISimulation;%./runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS*100;
%     totalOptimalPOIIRIS(:,i) = runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS;
%
% end
% percentageOfPOI=zeros(length(runNumber{1}.OutputUAVsimulationMain.percentageOfPOI),length(runNumber));
percentageOfPOI = zeros(length(runNumber{1}.POIsimulation),1);
bound_percetagePOI = zeros(1,2);
for i=1:1:length(runNumber)
    bound_percetagePOI_individual = zeros(1,2);
    y=0;
%     percentageOfPOI(:,i) = runNumber{i}.OutputUAVsimulationMain.percentageOfPOI;
    percentageOfPOI(:,i) = 100*(runNumber{i}.POIsimulation)/sum(runNumber{i}.IPV);
    if(runNumber{i}.MC_number>1)
        for j=1:1:length(runNumber{i}.IPV)
            x =ones(runNumber{i}.MC_number,1)*runNumber{i}.IPV(j);
            %             pd = fitdist(x,'Normal');
            
            pd = fitdist(sum(x),'Binomial','NTrials',length(x));
            [phat2,pci2] = mle(sum(x),'distribution','Binomial',"NTrials",length(x),'alpha',.05); % Generic distribution function
%             [phat,pci] = mle(x,'distribution','binomial','alpha',.05,'ntrials',1)

  


            temp = paramci(pd,'Alpha',1-CL);
            temp(1,2) = pci2(1);
            temp(2,2) = pci2(2);
            if (j>1)
                bound_percetagePOI_individual(1,1) = bound_percetagePOI_individual(1,1) + temp(1,2);
                bound_percetagePOI_individual(1,2) = bound_percetagePOI_individual(1,2) + temp(2,2);
            else
                bound_percetagePOI_individual(1,1) =  temp(1,2);
                bound_percetagePOI_individual(1,2) =  temp(2,2);
            end
        end
        %         x =ones(runNumber{i}.MC_number,1);
        
        %     pd = fitdist(x,'Binomial','NTrials',1)
        %     temp = pd.paramci;
        %     bound_percetagePOI(i,1) = temp(1,2)*runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS(1);
        %     bound_percetagePOI(i,2) = temp(2,2)*runNumber{i}.OutputUAVsimulationMain.totalOptimalPOIIRIS(1);
        bound_percetagePOI(i,:) = bound_percetagePOI_individual(1,:);
    end
end
violinPlot(percentageOfPOI,'addSpread',1.1,'xNames',labelesBoxPlot,'showMM',1)
% boxplot(percentageOfPOI,'Labels',labelesBoxPlot)
hold on;
bound_POI_num_min = 100;
for i=1:1:length(bound_percetagePOI(:,1))
    if(runNumber{i}.MC_number>1)
        
        bound_POI_num = bound_percetagePOI(i,:)/length(runNumber{i}.IPV)*100;
        
        if (bound_POI_num_min> bound_POI_num(1,1))
            bound_POI_num_min= bound_POI_num(1,1);
        end
        h1 =  plot([i-0.25 i+0.25],[bound_POI_num(1,1) bound_POI_num(1,1)],'b','Linewidth',2);
        plot([i-0.25 i+0.25],[bound_POI_num(1,2) bound_POI_num(1,2)],'b','Linewidth',2)
    end
end
ylim([65 100])

xlabel(titleXlabel)
ylabel('Percentage of POI[%]')
legend(h1,'CI','location','best')
% savefig(f5, figure_path5, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f5, figure_path5, '-dpdf');

%%
subplot(2,2,2)
% figure(2)
hold on; box on; grid on;
title('Collision probability')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
% Number_of_collision = 0;%=zeros(length(runNumber{1}.OutputUAVsimulationMain.Number_of_collision),length(runNumber));
bound_collision = zeros(length(runNumber{1}),2);
bound_collision_simulation = zeros(length(runNumber{1}),2);
    Number_of_collision = runNumber{i}.collisionVectorsimulation;

for i=1:1:length(runNumber)
    Number_of_collision(:,i) = runNumber{i}.collisionVectorsimulation;

    tempArray = 1:1:length(Number_of_collision(:,i));
    indexTemp = Number_of_collision(:,i)>0.5;
    Number_of_collision(tempArray(Number_of_collision(:,i)>0.5),i) = 1;
    if(runNumber{i}.MC_number>1)
%             bound_collision_individual = zeros(1,2);
%     Number_of_collision = Number_of_collision/(length(runNumber{i}.lengthVectorIRIS(:,1))-1)*100;
% 
%         for j=1:1:length(runNumber{i}.lengthVectorIRIS(:,1))
%                    x =zeros(length(runNumber{i}.MC_number),1);
% 
%             pd = fitdist(sum(x),'Binomial','NTrials',length(x));
%             [phat2,pci2] = mle(sum(x),'distribution','Binomial',"NTrials",length(x)); % Generic distribution function
%             temp = paramci(pd,'Alpha',1-CL);
%             temp(1,2) = pci2(1);
%             temp(2,2) = pci2(2);
%             if (j>1)
%                 bound_collision_individual(1,1) = bound_collision_individual(1,1) + temp(1,2);
%                 bound_collision_individual(1,2) = bound_collision_individual(1,2) + temp(2,2);
%             else
%                 bound_collision_individual(1,1) =  temp(1,2);
%                 bound_collision_individual(1,2) =  temp(2,2);
%             end
%         end
%                 bound_collision(i,:) = bound_collision_individual(1,:);
% bound_collision(i,:) = 100*bound_collision(i,:)/(length(runNumber{i}.lengthVectorIRIS(:,1))-1);
%      
         
%         x =zeros(length(runNumber{i}.MC_number)*(length(runNumber{i}.lengthVectorIRIS(:,1))-1),1);
%         pd = fitdist(x,'Binomial','NTrials',1);









       x =zeros(runNumber{i}.MC_number,1);
%         pd = fitdist(x,'Binomial','NTrials',runNumber{i}.MC_number);
%         pd = fitdist(sum(x),'Binomial','NTrials',length(x));

%         temp = paramci(pd,'Alpha',1-CL);
         
        
            [phat2,pci2] = mle(sum(x),'distribution','Binomial',"NTrials",length(x),'alpha',.05); % Generic distribution function
%             [phat,pci] = mle(x,'distribution','binomial','alpha',.05,'ntrials',1)

  


            temp = paramci(pd,'Alpha',1-CL);
            temp(1,2) = pci2(1);
            temp(2,2) = pci2(2);
        
        
%         bound_collision(i,1) = temp(1,2)*(length(runNumber{i}.lengthVectorIRIS(:,1))-1);
%         bound_collision(i,2) = temp(2,2)*(length(runNumber{i}.lengthVectorIRIS(:,1))-1);
%         
%           
        
     bound_collision(i,1) = temp(1,2) *100;
     bound_collision(i,2) = temp(2,2) *100;
        
        
    end
    
    
end
% boxplot(Number_of_collision,'Labels',labelesBoxPlot)
violinPlot(Number_of_collision,'addSpread',1.1,'xNames',labelesBoxPlot,'showMM',1)
% boxplot(Number_of_collision,'Labels',labelesBoxPlot)
% violinplot(Number_of_collision,labelesBoxPlot)

xlabel(titleXlabel)
ylabel('Collision probability')
hold on;


bound_collision_num_max = -1;

for i=1:1:length(bound_collision(:,1))
    if(runNumber{i}.MC_number>1)
        
        bound_collision_num = bound_collision(i,:);
        if (bound_collision_num_max< bound_collision_num(1,2))
            bound_collision_num_max= bound_collision_num(1,2);
        end
        h1 = plot([i-0.25 i+0.25],[bound_collision_num(1,1) bound_collision_num(1,1)],'b','Linewidth',2);
        plot([i-0.25 i+0.25],[bound_collision_num(1,2) bound_collision_num(1,2)],'b','Linewidth',2)
    end
end
% if (bound_collision_num_max > 50)
%     bound_collision_num_max = 50;
% end
ylim([0,bound_collision_num_max])
legend(h1,'CI','location','best')
% savefig(f2, figure_path2, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% print(f2, figure_path2, '-dpdf');



%%
subplot(2,2,3)
% close all
% figure(3)
hold on; box on; grid on;
title('Execution path length')
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
violinPlot(Total_length_simulation,'addSpread',1.1,'xNames',labelesBoxPlot,'showMM',1)
% violinPlot(Total_length_IRIS,'showMM',3)

xlabel(titleXlabel)
ylabel('Execution path length[m]')
%   Save results

bound_length_individual = zeros(1,2);
bound_length = zeros(1,2);
temp_lower = [0,0];
for i=1:1:length(runNumber)
    %         x =Total_length_planned(:,i);
    %     i
    %     runNumber{i}.MC_number
    if(runNumber{i}.MC_number>1)
        xraw = runNumber{i}.lengthVectorIRIS;
        x = [-diff(xraw)];
        for j=1:1:length(x(:,1))
            
            %             if(runNumber{i}.MC_number>30)
            %                 pd = fitdist(x(j,:)','Normal');
            %             else
            %                 pd = fitdist(x(j,:)','Poisson');
            %             end
            %             %             pd = fitdist(x(j,:)','Normal');
            %
            %             %             pd = fitdist(x(j,:)','Normal');
            %             pd = fitdist(x(j,:)','Normal');
            %             %             pd = fitdist(x(j,:)','Normal');
            %             temp = paramci(pd,'Alpha',1-CL);
            
            x_current = x(j,:)';
            SEM = std(x_current)/sqrt(length(x_current));
            [h,p,ci,stats] = ttest((x_current-mean(x_current))/(std(x_current)/sqrt(length(x_current))),0,'Alpha',0.05);
            
            temp(1:2) = mean(x_current)+ci*SEM;
            [phat,pci] = mle(x_current,'distribution','Normal','alpha',.05);
         
            SD = std(x_current);
             alpha = 0.05;
            N = length(x_current);
            UpperlimitStd =SD*sqrt((N-1)/chi2inv((alpha/2), N-1));
            LowerlimitStd =SD*sqrt((N-1)/chi2inv(1-(alpha/2), N-1));
% UpperlimitStd = 0;
% LowerlimitStd = 0;
            
            temp(1) = pci(1,1)-3*UpperlimitStd;
            temp(2) = pci(2,1)+3*UpperlimitStd;

            if (j>1)
                bound_length_individual(1) = bound_length_individual(1) + temp(1);
                bound_length_individual(2) = bound_length_individual(2) + temp(2);
                temp_lower(1) =temp_lower(1)+ pci(1,1)-3*LowerlimitStd;
                temp_lower(2) = temp_lower(2)+pci(2,1)+3*LowerlimitStd;
            else
                bound_length_individual(1) =  temp(1);
                bound_length_individual(2) =  temp(2);
                temp_lower(1) = pci(1,1)-3*LowerlimitStd;
                temp_lower(2) = pci(2,1)+3*LowerlimitStd;
            end
        end

        bound_length(i,:) = bound_length_individual(1,:);
        if (bound_length(i,1)<0)
            bound_length(i,1) = 0;
        end
        bound_length_lower(i,:) = temp_lower(1,:);
        if (bound_length_lower(i,1)<0)
            bound_length_lower(i,1) = 0;
        end

            x_current = xraw(1,:);
            mean(runNumber{i}.lengthVectorsimulation)
interval=ciFunc(x_current,95);
                        ci(1) = -interval;
                        ci(2) = interval;
                                 SD = std(x_current);
             alpha = 0.05;
            N = length(x_current);
            UpperlimitStd =SD*sqrt((N-1)/chi2inv((alpha/2), N-1));
%             UpperlimitStd=0;
            temp(1:2) = mean(x_current)+ci;
              temp(1) = temp(1)-3*UpperlimitStd;
            temp(2) = temp(2) +3*UpperlimitStd;

                bound_length(i,:) =  temp;
                
                
            LowerlimitStd =SD*sqrt((N-1)/chi2inv(1-(alpha/2), N-1));
%             LowerlimitStd=0;
            temp(1:2) = mean(x_current)+ci;
              temp(1) = temp(1)-3*LowerlimitStd;
            temp(2) = temp(2) +3*LowerlimitStd;
         bound_length_lower(i,:) =  temp;
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
        
    end
end
% ylim([min(min([bound_length,Total_length_simulation'])) max(max([bound_length,Total_length_simulation']))])
legend(h1,'CI for 6\sigma','location','best')

% size(temp(Total_length_simulation > bound_length(1) & Total_length_simulation < bound_length(2)))
%%

subplot(2,2,4)
% figure(4)
hold on; box on; grid on;
title('execution path length')
RunNumberVec = 0;
SearchTimeVec = 0;
for i=1:1:length(runNumber)
    RunNumberVec(i) = runNumber{i}.MC_number;
    SearchTimeVec(i) = runNumber{i}.SearchTime/1000;
end
plot(RunNumberVec,(SearchTimeVec),'b','Linewidth',3)
title('Search Time')
xlabel(titleXlabel)
ylabel(' Search Time[s]')
ax = gca;
ax.XAxis.TickLabels = labelesBoxPlot;
% ax.XAxis.TickLabels{1} = '0';
ax.XAxis.TickValues = 0;
for i=1:1:length(ax.XAxis.TickLabels)
    ax.XAxis.TickValues(i) = str2num(ax.XAxis.TickLabels{i})
end
% ax.XAxis.TickValues = [min(ax.XAxis.TickValues):min(diff(ax.XAxis.TickValues)):max(ax.XAxis.TickValues)];
ax.XAxis.TickLabels = labelesBoxPlot;
savefig(f5, figure_path5, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
print(f5, figure_path5, '-dpdf');
temp = [1:1:length(Total_length_simulation)];