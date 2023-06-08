clear all
% 0.8134,0.9103,0.9455
% close all
% folderPath = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\SubOptimalTests';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simple_test_m_kappa';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge_simple_test_m_kappa';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\result_with_rho_term\‏‏test_simple_subOptimal_MC';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\result_with_rho_term\‏‏test_bridge_simple_subOptimal_MC';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\result_with_rho_term\‏‏‏‏‏‏‏‏bridge_simple_suboptimal_MC_83_928_963_test1';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\result_with_rho_term\‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏bridge_simplify_MC__83_928_963';
% folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\result_with_rho_term\‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏‏simple_suboptimal_MC_83_928_963';

folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏‏‏Bridge_simple_mc_subOptimal';
folderDir = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏‏‏Bridge_simplify_mc_subOptimal';

% addpath Command

subFoldersNames = dir(folderDir);
numberOfRuns = length(subFoldersNames)-3;
runNumber = cell(1,1);

indexRuns=1;
tempIndex =1;

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
    runNumber{str2num(subFoldersNames(i).name(4:end))}.SearchTime =(temp(end-5));%temp(end-5);%
    runNumber{str2num(subFoldersNames(i).name(4:end))}.IsValidSolution = temp(5)>(temp(3)*temp(2)-1e-3);
    
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
%%
L=1;
mcVec = 1;
SearchTimeVec = 1;
index = 0;
for i=1:1:length(runNumber)
    if (runNumber{i}.IsValidSolution)
        index = index+1;
    mcVec(index) = runNumber{i}.MC_number;
    SearchTimeVec(index) = runNumber{i}.SearchTime/1000;
    end
end

mcVecMean = reshape(mcVec,[L,length(mcVec)/L ])';

f = figure(5);
f.Position = [100 100 700 200];
hold on; box on; grid on;

h=1;
index = 0;
    smoothTimes=5;
    SearchTimeMean=0;

[aa,bb] = find(diff(mcVec)<0);
if (L==1)
     for i=1:1:length(bb)+1
        if (i==1)
            
            SearchTimeMean = SearchTimeVec(1:bb(i));
            
            index = index+1;
            for j =1:1:smoothTimes
                SearchTimeMean = smooth(SearchTimeMean);
            end
            h(index) = plot(mcVec(1:bb(i)),SearchTimeMean,'linewidth',2);
            continue;
        end
        
        if i<=length(bb)
            
            SearchTimeMean = SearchTimeVec(bb(i-1)+1:bb(i));
            
            index = index+1;
            for j =1:1:smoothTimes
                SearchTimeMean = smooth(SearchTimeMean);
            end
            h(index) = plot(mcVec(bb(i-1)+1:bb(i)),SearchTimeMean,'linewidth',2);
            continue;
        else
            
             SearchTimeMean = SearchTimeVec(bb(i-1)+1:end);
            
            index = index+1;
            for j =1:1:smoothTimes
                SearchTimeMean = smooth(SearchTimeMean);
            end
            h(index) = plot(mcVec(bb(i-1)+1:end),SearchTimeMean,'linewidth',2);
        end
    end
else
    diffIndex = unique(diff(bb));
    
    
    for i=1:1:length(diffIndex)
        if (i==1)
            
            SearchTimeMean = mean(reshape(SearchTimeVec(1:diffIndex(i)*L),[L,diffIndex(i)]));
            
            index = index+1;
            for j =1:1:smoothTimes
                SearchTimeMean = smooth(SearchTimeMean);
            end
            h(index) = plot(mcVec(1:diffIndex(i)),SearchTimeMean,'linewidth',2);
            continue;
        end
        
        if i<length(diffIndex)
            
            SearchTimeMean = mean(reshape(SearchTimeVec(bb((i-1)*L)+1:bb((i)*L)),[L,diffIndex(i)]));
            
            index = index+1;
            for j =1:1:smoothTimes
                SearchTimeMean = smooth(SearchTimeMean);
            end
            h(index) = plot(mcVec(bb((i-1)*L)+1:bb((i-1)*L)+diffIndex(i)),SearchTimeMean,'linewidth',2);
            continue;
        else
            
            SearchTimeMean = mean(reshape(SearchTimeVec(bb((i-1)*L)+1:end),[L,diffIndex(i)]));
            
            
            index = index+1;
            for j =1:1:smoothTimes
                SearchTimeMean = smooth(SearchTimeMean);
            end
            h(index) = plot(mcVec(bb((i-1)*L)+1:bb((i-1)*L)+diffIndex(i)),SearchTimeMean,'linewidth',2);
        end
    end
end
% xlabel('$m$ for $\langle m,\kappa \rangle$','fontsize',12,'Interpreter','latex')
xlabel('$m$','fontsize',12,'Interpreter','latex')

ylabel('Search time [s]','fontsize',12)
% legend('$\hat{p}_{desired}^- = 0.97$','$\hat{p}_{desired}^- = 0.93$','$\hat{p}_{desired}^- = 0.9$','$\hat{p}_{desired}^- = 0.85$','$\hat{p}_{desired}^- = 0.64$','location','best','Interpreter','latex');

% legend('$\hat{p}_{desired}^- = 0.97$','$\hat{p}_{desired}^- = 0.93$','$\hat{p}_{desired}^- = 0.9$','$\hat{p}_{desired}^- = 0.85$','$\hat{p}_{desired}^- = 0.64$','location','best','Interpreter','latex');
legend('$\hat{p}_{desired}^- = 0.81$','$\hat{p}_{desired}^- = 0.91$','$\hat{p}_{desired}^- = 0.94$','location','best','Interpreter','latex');
% 34,0.9103,0.9455
set(gca, 'YScale', 'log')
yticks([0.01,0.1,0.2,0.3,0.4,1,2,5,10,30, 50 100 200 400 800 1200 10000 25000])
ax = gca;
ax.FontSize = 14; 
%%
%subplot(2,2,4)

% title('execution path length')
% RunNumberVec = 0;
% SearchTimeVec = 0;
% 
% mc=1;
% for i=1:1:length(runNumber)
%     mc(i) = runNumber{i}.MC_number;
%     SearchTimeVec(i) = runNumber{i}.SearchTime/1000;
%     
% end
% 
% start_indices = find(mc == mc(1));
% mc1 = reshape(mc, [min(diff(start_indices)) length(start_indices)])';
% SearchTimeVec1 = reshape(SearchTimeVec, [min(diff(start_indices)) length(start_indices)])';
% 
% mc2 = mc(start_indices(1):start_indices(2)-1);
% meantotalLengthMean2 = mean(SearchTimeVec1);
% 
% % for i=1:1:length(start_indices)
% %     h1= plot(mc1(i,:),(SearchTimeVec1(i,:)),'b*','linewidth',2);
% % end
% for i=1:1:length(start_indices)/5
%     h1= plot(mc1(i,2:end),(SearchTimeVec1(i,2:end)),'linewidth',2);
% end
% xlabel('$m$ for $\langle m,\kappa \rangle$','fontsize',12,'Interpreter','latex')
% ylabel('Search time [s]','fontsize',12)
% legend('$\hat{p}_{desired}^- = 1$','$\hat{p}_{desired}^- = 0.97$','$\hat{p}_{desired}^- = 0.93$','$\hat{p}_{desired}^- = 0.9$','location','best','Interpreter','latex');
% 
% % plot(RunNumberVec,(SearchTimeVec),'b','Linewidth',3)
% % title('Search Time')
% % xlabel('$m$','fontsize',12,'fontsize',12,'Interpreter','latex')
% % ylabel(' Search Time [s]','fontsize',12)
% set(gca, 'YScale', 'log')
% yticks([10,50,100,500, 900 ])
% ylim([min((SearchTimeVec)),max(SearchTimeVec)+1])
% 
% ax = gca;
% ax.XAxis.TickLabels{1} = 'IRIS';
% % savefig(f5, figure_path5, 'compact');  %   Compressed fig. Can only be opened in MATLAB 2014b or above.
% % print(f5, figure_path5, '-dpdf');
%%

% subFoldersNames = dir(folderPath);
% kappa = [90:2:100];
% mc = [0,10,20,30,50,100];
% ipv_num=27;
% SearchTime = zeros(length(kappa),length(mc));
% GeneratedNode = zeros(length(kappa),length(mc));
% pathlength = zeros(length(kappa),length(mc));
% ci_lower=zeros(length(kappa),length(mc));
% CL = 0.95;
% alpha = 1-CL;
%
% index_kappa = 0;
% index_mc = 0;
% RunIndexMC = 0;
% RunIndexKappa = 0;
%
% RefSearchTime = 0;
% RefPathLength =0;
% for i=3:1:length(subFoldersNames)
%     subsubfoler = dir([folderPath,'\',subFoldersNames(i).name]);
%     index_kappa = index_kappa+1;
%
%     index_mc = 0;
%     for j=3:1:length(subsubfoler)
%         if (strcmp(subsubfoler(j).name,['Run',num2str(0)]))
%             continue;
%         end
%         if (strcmp(subsubfoler(j).name,['Run',num2str(1)]))
%             %
%             data = importdata([folderPath,'\',subFoldersNames(i).name,'\',subsubfoler(j).name,'\','testIRIS']);
%
%             RefSearchTime = RefSearchTime+(data(end-5)/1000);
%             RefPathLength =RefPathLength+data(6);
%             continue;
%         end
%         index_mc = index_mc+1;
%         data = importdata([folderPath,'\',subFoldersNames(i).name,'\',subsubfoler(j).name,'\','testIRIS']);
%
%         RunIndexMC = str2num(subsubfoler(j).name(4:end));
%         temp_a = subFoldersNames(i).name;
%         RunIndexKappa = find(str2num(temp_a(11:end))==kappa);
%         SearchTime(RunIndexKappa,RunIndexMC) = (data(end-5)/1000);
%         GeneratedNode(RunIndexKappa,RunIndexMC) = data(end-1)+data(end);
%         pathlength(RunIndexKappa,RunIndexMC) = data(6);
%         x =(kappa(RunIndexKappa)/100)*ones(mc(RunIndexMC),1);
%         [phat,pci] = binofit((sum(x)),length(x),alpha);
%         ci_lower(RunIndexKappa,RunIndexMC) = pci(1)*100;%mean(pci)*100;%phat*100;%
%     end
%     %     SearchTime(index_kappa,:) = SearchTime(index_kappa,RunIndexMC);
%     %     GeneratedNode(index_kappa,:) = GeneratedNode(index_kappa,RunIndexMC);
%     %     pathlength(index_kappa,:) = pathlength(index_kappa,RunIndexMC);
%     %     ci_lower(index_kappa,:) = ci_lower(index_kappa,RunIndexMC);
% end
%
% RefSearchTime = RefSearchTime/length(mc);
% RefPathLength =RefPathLength/length(mc);
% RefPOI = 64;
% MLU_path_length = 27;
% MLUPOI = 92;
% % [A,sortIdx] = sort(RunIndexKappa,'ascend');
% %
% % SearchTime = SearchTime(sortIdx,:)/1000;
% % GeneratedNode=GeneratedNode(sortIdx,:);
% % pathlength = pathlength(sortIdx,:);
% % ci_lower=ci_lower(sortIdx,:);
%
%
% f=figure(1);
% f.Position = [100,100,200,500];
% % subplot(1,3,1)
% hold on; box on; grid on;
% h=0;
% Legend=cell(1,1);
% for i=1:1:length(kappa)
%     h(i) = plot(mc,smooth(smooth(ci_lower(i,:))),'LineWidth',2);
%     Legend{i}=['\kappa = ',num2str(kappa(i)),'[%]'] ;
% end
% plot([min(mc),max(mc)],RefPOI*ones(1,2),'k--','LineWidth',2);
% plot([min(mc),max(mc)],MLUPOI*ones(1,2),'b--','LineWidth',2);
% Legend{i+1} = 'IRIS execution';
% Legend{i+2} = 'IRIS-MLU execution';
% legend(Legend,'location','best');
%
%
% xlim([20,100])
%
% % title('CI lower bound Coverage')
% xlabel('m')
% ylabel('CI lower bound Coverage [%]')
% % legend(Legend,'location','best');
%
% % subplot(1,3,2)
% f=figure(2);
% f.Position = [350,100,200,500];
% hold on; box on; grid on;
% h=0;
% Legend=cell(1,1);
% for i=1:1:length(kappa)
%     h(i) = plot(mc,smooth(smooth(SearchTime(i,:))),'LineWidth',2);
%     Legend{i}=['\kappa = ',num2str(kappa(i)),'[%]'] ;
% end
% plot([min(mc),max(mc)],RefSearchTime*ones(1,2),'k--','LineWidth',2);
% xlim([20,100])
% set(gca, 'YScale', 'log')
% yticks([0.1 0.2 0.5  1 2])
% % ylim([0,10])
% % title('Search Time')
% xlabel('m')
% ylabel('Search Time [s]')
%
% % subplot(1,3,3)
% f=figure(3);
% f.Position = [650,100,200,500];
% hold on; box on; grid on;
% h=0;
% Legend=cell(1,1);
% for i=1:1:length(kappa)
%     h(i) = plot(mc,smooth(smooth(pathlength(i,:))),'LineWidth',2);
%     Legend{i}=['\kappa = ',num2str(kappa(i)),'[%]'] ;
% end
% plot([min(mc),max(mc)],RefPathLength*ones(1,2),'k--','LineWidth',2);
% plot([min(mc),max(mc)],MLU_path_length*ones(1,2),'b--','LineWidth',2);
%
%
%
%
% xlim([20,100])
% % title('Command-path length')
% xlabel('m')
% ylabel('Path length [m]')
% % legend(Legend,'location','best');