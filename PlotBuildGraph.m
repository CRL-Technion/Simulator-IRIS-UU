% clc
clear all
close all
IRIS_build_folder='\\wsl$\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build';
% IRIS_build_folder='C:\Users\david\OneDrive - Technion\Master\UAV_Simulation\Results\test_080321_1946_squre_tolerance_cost\runNumber1\IRISOutput';

edge = importdata([IRIS_build_folder,'\testIRIS_edge']);
configuration = importdata([IRIS_build_folder,'\testIRIS_conf']); 

figure(1)
box on; grid on; hold on;
BridgeObj = readObj('\\wsl$\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\data\bridge\bridgeTestLarge.obj');
plot3(BridgeObj.v(:,1),BridgeObj.v(:,2),BridgeObj.v(:,3),'b*')
Environment.obj = BridgeObj;
patch('vertices', Environment.obj.v, 'faces', Environment.obj.f.v, ...
    'FaceVertexCData', rand(length(Environment.obj.v),1));
shading interp
alpha(.1)

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
%%
% clear all
% close all
IRIS_build_folder='\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build\Results\test_!1\Run0';
% IRIS_build_folder='C:\Users\david\OneDrive - Technion\Master\UAV_Simulation\Results\test_100321_2252_yMinus2_tolerance_cost\runNumber1\IRISOutput';
IRIS_build_folder='\\wsl$\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build';

edge = importdata([IRIS_build_folder,'\testIRIS_edge']);
configuration = importdata([IRIS_build_folder,'\testIRIS_conf']); 
figure(3)
box on; grid on; hold on;
[aa,bb] = find(edge(:,4)>-2);
soucre = configuration(edge(aa,1)+1,1:3);
target = configuration(edge(aa,2)+1,1:3);
  plot3(soucre(:,1),soucre(:,2),soucre(:,3),'r*');
    plot3(target(:,1),target(:,2),target(:,3),'b*');
    for i=1:1:length(aa)
            plot3([soucre(i,1),target(i,1)],[soucre(i,2),target(i,2)],[soucre(i,3),target(i,3)],'k');

    end
%     plot3([soucre(:,1),target(:,1)],[soucre(:,2),target(:,2)],[soucre(:,3),target(:,3)],'k');

%     startPoint = [-102.14 -5.51009 -5.41875];
%     normS = norm(startPoint);
%     psi = -1.21777;
%     startPoint(2,1:3) = startPoint+10*[cos(psi),sin(psi),startPoint(1,3)];
%     plot3(startPoint(:,1),startPoint(:,2),startPoint(:,3),'lineWidth',2)
%%
% load('UAVSimulationResults.mat');
% plot3(Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3),'LineWidth',2);
figure(1)
box on; grid on; hold on;
plot3(TargetPo(:,1),TargetPo(:,2),TargetPo(:,3),'b*')
plot3(startCon(:,1),startCon(:,2),startCon(:,3),'r*')