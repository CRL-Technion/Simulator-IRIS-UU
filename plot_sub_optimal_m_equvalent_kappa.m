clear all
close all
folderPath = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_trade_off_toy';
subFoldersNames = dir(folderPath);
SearchTime = 0;
mc =0; 

L= length(subFoldersNames)-3;
% mc_size = 6;
% row_index = floor(23/mc_size)+1;
% col_index = 23-mc_size*(row_index-1);
% mc = zeros(mc_size,L/mc_size);
% SearchTime = zeros(mc_size,L/mc_size);
mc=0;
SearchTime=0;
% index = 0;
for i=3:1:length(subFoldersNames)
     if (~strcmp(subFoldersNames(i).name(1:3),'Run'))
       continue;
     end
    numOfRunFolder = str2num(subFoldersNames(i).name(4:end));
    if (numOfRunFolder==0)
            continue;
    end
%        index = index+1;
%        row_index = floor((numOfRunFolder-0.99)/mc_size)+1;
% col_index = numOfRunFolder-mc_size*(row_index-1);
           data =   importdata([folderPath,'\',subFoldersNames(i).name,'\','LocationErrorParameterFile']); 
           mc(numOfRunFolder) =  data(end-1);
    data = importdata([folderPath,'\',subFoldersNames(i).name,'\','testIRIS']);
     SearchTime(numOfRunFolder) = (data(end-5)/1000);
         
end 
 %%
diffmc = diff(mc);
[aa,bb]=find(diffmc<0);
f=figure(1);
f.Position = [100,100,500,200];
hold on; box on; grid on;
plot(mc(bb(end)+1:end),(SearchTime(bb(end)+1:end)),'LineWidth',2);

for i=0:1:length(bb)-1
    i
    if (i==0)
    plot(mc(1:bb(i+1)),((SearchTime(1:bb(i+1)))),'LineWidth',2);
    end
    if (i>0 && i < length(bb) )
    plot(mc(bb(i)+1:bb(i+1)),(SearchTime(bb(i)+1:bb(i+1))),'LineWidth',2);
    end
    if (i== length(bb) )
    plot(mc(bb(i)+1:end),(SearchTime(bb(i)+1:end)),'LineWidth',2);
    end
end

% f=figure(1);
% f.Position = [100,100,500,200];
% hold on; box on; grid on;
% for i=1:1:length(mc(1,:))
% plot(mc(i,:),(SearchTime(i,:)),'LineWidth',2);
% 
% end
legend('$\hat{p}_{desired}^- = 0.64$','$\hat{p}_{desired}^- = 0.85$','$\hat{p}_{desired}^- = 0.9$','$\hat{p}_{desired}^- = 0.93$','$\hat{p}_{desired}^- = 0.97$','location','best','Interpreter','latex');

% xlabel('m and eqauvalent $\kappa$','Interpreter','latex','fontsize',12)
xlabel('$m$ for $\langle m,\kappa \rangle$','fontsize',12,'Interpreter','latex')
ylabel('Search time [s]','fontsize',12)
% yticks([0:0.2:100])
% ylim([0,1.7])
set(gca, 'YScale', 'log')
yticks([0,0.1,0.2,0.5,1,2,3,4,5])