% clc
clear all
close all
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\bridge_scenario_2m_100vertices\Run3';
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\Bridge100MC_95POI\Run1';


% IRIS_build_folder='C:\Users\david\OneDrive - Technion\Master\UAV_Simulation\Results\test_080321_1946_squre_tolerance_cost\runNumber1\IRISOutput';
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏bridge_simple_10000_MC_no_IPV_coll0\Run2';
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build';
% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏bridge_simple_10000_MC\Run6';
edge = importdata([IRIS_build_folder,'\testIRIS_edge']);
configuration = importdata([IRIS_build_folder,'\testIRIS_conf']); 

figure(1)
box on; grid on; hold on;
% BridgeObj = readObj('\\wsl$\Ubuntu-20.04\home\davidalpert\Projects\IRIS\data\bridge\bridge_small.obj');
Command = InitCommand('testIRIS',[IRIS_build_folder,'\']);


% plot3(BridgeObj.v(:,1),BridgeObj.v(:,2),BridgeObj.v(:,3),'b*')
% plot3(BridgeObj.v(Command.POIUnique,1),BridgeObj.v(Command.POIUnique,2),BridgeObj.v(Command.POIUnique,3),'b*')
% Environment.obj = BridgeObj;
Environment = GetEnvironmentMission('\\wsl$\Ubuntu-20.04\home\davidalpert\Projects\IRIS\data\bridge\')
h1= patch('vertices', Environment.obj.v(:,1:3), 'faces', Environment.obj.f.v, ...
    'FaceVertexCData', rand(length(Environment.obj.v),1));
shading interp
alpha(.3)
% plot3(Environment.TargetsBridge(Command.POIUnique,1),Environment.TargetsBridge(Command.POIUnique,2),Environment.TargetsBridge(Command.POIUnique,3),'r*','linewidth',3)

% toy POI
% x = [-95:2:95];
% y = -11*ones(size(x));
% z = -5*ones(size(x));
% plot3(x,y,z,'r*','linewidth',3)

% xmin = -100;
% xmax = 100;
% ymin=-11;
% ymax =1;
% zmin = -20;
% zmax = 0;
% 
% plotquarter(xmin,xmax,ymin,ymax,zmin)
% plotquarter(xmin,xmax,ymin,ymax,zmax)
% plotquarter(xmin,xmax,zmin,zmax,ymin)
% plotquarter(xmin,xmax,zmin,zmax,ymax)
% plotquarter(ymin,ymax,zmin,zmax,xmin)
% plotquarter(ymin,ymax,zmin,zmax,xmax)

% clear all
% close all
% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build';
% IRIS_build_folder='C:\Users\david\OneDrive - Technion\Master\UAV_Simulation\Results\test_100321_2252_yMinus2_tolerance_cost\runNumber1\IRISOutput';
% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\test_MC_NoiseGPS_bridge\Run1';
% IRIS_build_folder = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build\Results\yMinus11_Stop_280521\Run0';
edge = importdata([IRIS_build_folder,'\testIRIS_edge']);
configuration = importdata([IRIS_build_folder,'\testIRIS_conf']); 
% figure(3)
box on; grid on; hold on;
% [aa,bb] = find(edge(:,4)>-2);
%toy scenario
aa = 1:1:length(edge);
soucre = configuration(edge(aa,1)+1,1:3);
target = configuration(edge(aa,2)+1,1:3);
 h2 =   plot3(soucre(:,1),soucre(:,2),soucre(:,3),'k*','linewidth',3);
%     plot3(target(:,1),target(:,2),target(:,3),'b*','linewidth',3);
           plot3([soucre(:,1),target(:,1)]',[soucre(:,2),target(:,2)]',[soucre(:,3),target(:,3)]','Color',[0, 0, 0, 0.3]);
%     plot3([soucre(:,1),target(:,1)],[soucre(:,2),target(:,2)],[soucre(:,3),target(:,3)],'k');

targetPointsIndex = importdata([IRIS_build_folder,'\targetsBuildIndex']);
[aa,bb] = find(targetPointsIndex==1);
targetPoints = importdata([IRIS_build_folder,'\targetsPoints']);
           h3 =    plot3(targetPoints(aa,1),targetPoints(aa,2),targetPoints(aa,3),'r*','linewidth',3);
         
%            h4 =    plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'b','linewidth',3);
%            h5 =    plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'r','linewidth',3);



% legend([h1,h2,h3],'Bridge','Vertices','POIs','location','best')
% legend([h4,h5],'IRIS','IRIS-U^2','location','best')
% legend([h1,h2,h3,h4],'Bridge','Vertices','POIs','IRIS','location','best')
% legend([h1,h2,h3,h5],'Bridge','Vertices','POIs','IRIS-U^2','location','best')
legend([h1,h2,h3],'Bridge','Vertices','POIs','location','best');
xlabel('x[m]','fontsize',12);
ylabel('y[m]','fontsize',12);
zlabel('z[m]','fontsize',12);

%     startPoint = [-102.14 -5.51009 -5.41875];
%     normS = norm(startPoint);
%     psi = -1.21777;
%     startPoint(2,1:3) = startPoint+10*[cos(psi),sin(psi),startPoint(1,3)];
%     plot3(startPoint(:,1),startPoint(:,2),startPoint(:,3),'lineWidth',2)
ax = gca;
ax.FontSize = 14; 


%%
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏Bridge_simplify_mc_combine\Run5';
% IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\‏‏bridge_simple_10000_MC_no_IPV_coll0\Run2';

% 
Command = InitCommand('testIRIS',[IRIS_build_folder,'\']);
% h4 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'color',[0 0.4470 0.7410],'linewidth',3)
% h5 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'color',[0.9290 0.6940 0.1250],'linewidth',3)
h6 = plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'color',[0.8500 0.3250 0.0980],'linewidth',3)

% legend([h4,h5,h6],'IRIS','LUM','IRIS-U^2','location','best');

%%
% load('UAVSimulationResults.mat');
% plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'LineWidth',2);
% figure(1)
% box on; grid on; hold on;
% plot3(TargetPo(:,1),TargetPo(:,2),TargetPo(:,3),'b*')
% plot3(startCon(:,1),startCon(:,2),startCon(:,3),'r*')