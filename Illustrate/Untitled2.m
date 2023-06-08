close all
clear all
clc
%%
% close all
% OBJ=read_wobj('C:\Users\david\OneDrive - Technion\Master\objTest\simpleExample.obj');

OBJ=readObj('C:\Users\david\OneDrive - Technion\Master\objTest\simpleExample.obj');
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\SimpleScenario_1_3\Run1';
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏Toy_10000_mc_combine\Run1';
% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build';
% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\simple_test_500_mc_replan\Run1';


figure(1)
 %subplot(2,1,2)

  box on; grid on; hold on;  

% title('IRIS-UU')
  h1 = patch('Vertices', OBJ.v(:,1:3), 'Faces', OBJ.f.v,'FaceColor','red');
alpha(.3)
  pgon = polyshape([-20 -20 20 20], [-1 1 1 -1]);
h7 = plot(pgon,'FaceColor','red','FaceAlpha',0.1)
pgon = polyshape([-20 -20 20 20], [-4.1 -1 -1 -4.1]);
plot(pgon,'FaceColor','b','FaceAlpha',0.1)
pgon = polyshape([-20 -20 20 20], [1 6 6 1]);
h8 = plot(pgon,'FaceColor','b','FaceAlpha',0.1)
%   FV.faces=[
%   OBJ.objects(3).data.vertices
%     OBJ.objects(7).data.vertices;
%   OBJ.objects(11).data.vertices];
%  figure(1)
%   box on; grid on; hold on;   
% FV.faces=[
%   OBJ.objects(4).data.vertices
%     OBJ.objects(8).data.vertices
%   OBJ.objects(12).data.vertices
%   OBJ.objects(16).data.vertices
%   OBJ.objects(20).data.vertices
%   OBJ.objects(24).data.vertices];
% h1 = patch('Faces',FV.faces,'Vertices',FV.vertices,'FaceColor','red')
%  
%   h1 = patch(FV,'facecolor',[1 0 0]); camlight

%  figure(1)
%   box on; grid on; hold on;   
% FV.faces=[
%   OBJ.objects(4).data.vertices
%     OBJ.objects(8).data.vertices
%   OBJ.objects(12).data.vertices
%   OBJ.objects(16).data.vertices
%   OBJ.objects(20).data.vertices
%   OBJ.objects(24).data.vertices];
% h1 = patch('Faces',OBJ.f,'Vertices',OBJ.v,'FaceColor','red')


% alpha(.3)
  
xyz = [
-12.4 4 0
-12.2 4 0
-12 4 0
-9.4 4 0
-9.2 4 0
-9 4 0
-6.4 4 0
-6.2 4 0
-6 4 0
-3.4 4 0
-3.2 4 0
-3 4 0
-0.4 4 0
-0.2 4 0
-3.27826e-07 4 0
2.6 4 0
2.8 4 0
3 4 0
5.6 4 0
5.8 4 0
6 4 0
8.6 4 0
8.8 4 0
9 4 0
11.6 4 0
11.8 4 0
12 4 0];

x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);
h2 = plot3(x,y,z,'r*','linewidth',3)

% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build';
edge = importdata([IRIS_build_folder,'\testIRIS_edge']);
configuration = importdata([IRIS_build_folder,'\testIRIS_conf']); 


% [aa,bb] = find(edge(:,4)>-2);

%toy scenario
aa = 1:1:length(edge);
soucre = configuration(edge(aa,1)+1,1:3);
target = configuration(edge(aa,2)+1,1:3);
h3 =  plot3(soucre(:,1),soucre(:,2),soucre(:,3),'k*','linewidth',3);
 plot3(target(:,1),target(:,2),target(:,3),'k*','linewidth',3);
 
 text(configuration(:,1),configuration(:,2)+0.3,configuration(:,3),num2cell([0:1:length(configuration(:,1))-1]))

%     plot3(target(:,1),target(:,2),target(:,3),'b*','linewidth',3);
h_edges = plot3([soucre(:,1),target(:,1)]',[soucre(:,2),target(:,2)]',[soucre(:,3),target(:,3)]','--','Color',[0, 0, 0, 0.8]);
%     plot3([soucre(:,1),target(:,1)],[soucre(:,2),target(:,2)],[soucre(:,3),target(:,3)],'k');
% plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'b','linewidth',3)


IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏Toy_10000_mc_combine\Run5';
% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏test_simple_10000_MC_mlu\Run2';

% 
Command = InitCommand('testIRIS',[IRIS_build_folder,'\']);
% h5 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'b','linewidth',3)
% h4 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'color',[0 0.4470 0.7410],'linewidth',3)
% h5 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'color',[0.9290 0.6940 0.1250],'linewidth',3)
h6 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'color',[0.8500 0.3250 0.0980],'linewidth',3)

% h4 = plot3(CommandIRIS(:,1),CommandIRIS(:,2),CommandIRIS(:,3),'color',[0 0.4470 0.7410],'linewidth',3)
% h5 = plot3(CommandIRISMLU(:,1),CommandIRISMLU(:,2),CommandIRISMLU(:,3),'color',[0.9290 0.6940 0.1250],'linewidth',3)
% h6 = plot3(CommandIRISUU(:,1),CommandIRISUU(:,2),CommandIRISUU(:,3),'color',[0.8500 0.3250 0.0980],'linewidth',3)
% 


% Command = InitCommand('testIRIS',[IRIS_build_folder,'\']);
% h5 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'b','linewidth',3)
% Command = InitCommand('testIRIS',[IRIS_build_folder,'\']);
% plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'r','linewidth',3)
%  plot3(RecordState.X(1,:),RecordState.X(2,:),RecordState.X(3,:),'r','linewidth',3)
%  plot3(RecordState.X(1,1:10000),RecordState.X(2,1:10000),RecordState.X(3,1:10000),'b','linewidth',3)
% 
% plot3(RecordState.X(1,10000:end),RecordState.X(2,10000:end),RecordState.X(3,10000:end),'r','linewidth',3)
% 
% Command = InitCommand('testIRIS',[IRIS_build_folder,'\']);

% for i=1:1:5
% noise = 1.5;
% PoseUpdateTheta = Command.Pose_des_GF;
% 
%   State.X = Command.Pose_des_GF(1,1:3)';
%     if (checkGPSAvailable(State))
%                     r = abs(rand_mu_sigma(0,1,1,1)*1);
%     else
%                     r = abs(rand_mu_sigma(0,1,1,1)*3);
%     end
%                azimuth = rand_mu_sigma(0,2*pi,1,1);
%             elevation = rand_mu_sigma(0,2*pi,1,1);
% lastError = [
%     r * cos(elevation) * cos(azimuth)
% r * cos(elevation) * sin(azimuth)
% -r * sin(elevation)];
% for i=2:1:length(Command.Pose_des_GF(:,1))
%     State.X = Command.Pose_des_GF(i,1:3)'+lastError;
%     if (checkGPSAvailable(State))
%                     r = abs(rand_mu_sigma(0,1,1,1)*1);
%     else
%                     r = abs(rand_mu_sigma(0,1,1,1)*3);
%     end 
%                azimuth = rand_mu_sigma(0,2*pi,1,1);
%             elevation = rand_mu_sigma(0,2*pi,1,1);
% lastError = [
%     r * cos(elevation) * cos(azimuth)
% r * cos(elevation) * sin(azimuth)
% -r * sin(elevation)];
%     PoseUpdateTheta(i,1:3) = (Command.Pose_des_GF(i,1:3)'+lastError)';
%     
% end
% h5 = plot3(PoseUpdateTheta(:,1),PoseUpdateTheta(:,2),PoseUpdateTheta(:,3),'b','Color',[0, 0, 0, 0.5])
% end




% legend([h1,h2,h3,h4,h5],'Obstacle','POIs','Vertices','Trajectory-iris-command','Trajectory-executed [100MC]')
% legend([h1,h2,h3,h4],'Obstacle','POIs','Vertices','Trajectory-iris','location','best')
xlabel('x[m]','Fontsize',12)
ylabel('y[m]','Fontsize',12)
zlabel('z[m]','Fontsize',12)

% legend([h1,h2,h3,h4,h5,h6,h7],'Obstacle','POIs','Vertices','Trajectory-iris-command','Trajectory-iris-execution[5MC]','\sigma = 3','\sigma = 1','location','best')
% legend([h1,h2,h3,h4,h6,h7],'Obstacle','POIs','Vertices','Command path','\sigma = 3','\sigma = 1','location','best')
legend([h1,h2,h3,h7,h8],'Obstacle','POIs','Vertices','\sigma = 3','\sigma = 1','location','best')
% legend([h1,h2,h3,h4,h5,h6,h7],'Obstacle','POIs','Vertices','IRIS path','IRIS-LLU\IRIS-MLU path','\sigma = 3','\sigma = 1','location','best')
% h8 = h5;
% legend([h1,h2,h3,h4,h5,h6,h7],'Obstacle','POIs','Vertices','IRIS','IRIS-MLU','\sigma = 3','\sigma = 1','location','best')
%  X = [0.93 0.93];
%  Y = [0.6   0.7];
%  annotation('arrow',X,Y);
%  annotation('textbox',[.9 .4 .1 .2], ...
%     'String','North','EdgeColor','none')
%  
% P = plot_arc(pi/2-pi/3,pi/2+pi/3,-14,0.1,1.5);
% set(P,'linewidth',0.001)
% legend([h1,h2,h3,h4,h6,h7],'Obstacle','POIs','Vertices','IRIS-U^2','\sigma = 3','\sigma = 1','location','best');
% legend([h1,h2,h3,h_edges(1),h6,h7],'Obstacle','POIs','Vertices','Edges','\sigma = 3','\sigma = 1','location','best');
% legend([h4,h5,h6],'IRIS','LUM','IRIS-U^2','location','best');
 xlim([-16 16])
ylim([-4.1 4.1])
ax = gca;
ax.FontSize = 14; 
%%
% x = randi(50, 1, 100);                      % Create Data
% x = [0,0,0];
% [h,p,ci,stats] = ttest(x)
% ci
% %%
% pd = fitdist(x','Normal');
% ci = paramci(pd)
% SEM = std(x)/sqrt(length(x));               % Standard Error
% ts = tinv([0.025  0.975],length(x)-1);      % T-Score
% CI = mean(x) + ts*SEM                     % Confidence Intervals