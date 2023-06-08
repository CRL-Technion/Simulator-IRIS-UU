close all
clear all
clc
%%
xc = [0,3,-3,6,-6];
radiusCircle = 0.6;
FOV = atan(0.5/5)+0.15;
VerticesLocationX = [4.5,1.5,-1.5,-4.5];
POILocaitonY = 5;
VerticesLocationY = -2.5*ones(1,length(VerticesLocationX));
VerticesLocation = [VerticesLocationX;VerticesLocationY];
x = [-7:0.01:7]';
POIStrip = [x,ones(length(x),1)*POILocaitonY]';


figure(1)
subplot(1,2,2)
hold on;grid on; box on;
commandpath = plot(VerticesLocationX,VerticesLocationY,'o-','linewidth',2,'color',[0 0 1]);
for i=1:1:length(VerticesLocationX)
r = 10;

teta = pi/2+FOV;
x = [VerticesLocation(1,i),VerticesLocation(1,i)+r *cos(teta)];
y = [VerticesLocation(2,i),VerticesLocation(2,i)+r *sin(teta)];
plot(x,y,'b--','lineWidth',2)
teta = pi/2-FOV;

x = [VerticesLocation(1,i),VerticesLocation(1,i)+r *cos(teta)];
y = [VerticesLocation(2,i),VerticesLocation(2,i)+r *sin(teta)];
plot(x,y,'b--','lineWidth',2)
end

M_command =0;
for i=1:1:length(POIStrip)
    p=0;
    for j=1:1:length(VerticesLocation)
        p = 1-(1-p)*(1-IsInspectPOI(VerticesLocation(:,j),POIStrip(:,i),xc,radiusCircle,FOV));
    end
    M_command(i) = p;
end

%command-coverage
% Define x, f(x), and M(x)
x = POIStrip(1,:);
fUpper = (POILocaitonY+0.5)*ones(length(x),1);
fLower = POILocaitonY*ones(length(x),1);
% M = -x+7;
% Define the vertices: the points at (x, f(x)) and (x, 0)
N = length(x);
verts = [x(:), fUpper(:); x(:) fLower(:)];
% Define the faces to connect each adjacent f(x) and the corresponding points at y = 0.
q = (1:N-1)';
faces = [q, q+1, q+N+1, q+N];
p_command = patch('Faces', faces, 'Vertices', verts, 'FaceVertexCData', [M_command(:); M_command(:)], 'FaceColor', 'interp', 'EdgeColor', 'none');
uistack(p_command,'top');

xlim([-6.5 6.5]);
ylim([-4.5 POILocaitonY+0.5]);
% 
% grayColor = [0.7 .7 0.5,0.1];
% mc = 5;
% M_execution =zeros(length(POIStrip),1);
% 
% for j=1:1:mc
%     PoseUpdateTheta = VerticesLocation;
%     for i=1:1:length(PoseUpdateTheta)
%         r = abs(rand_mu_sigma(0,1,1,1)*1);
%         azimuth = rand_mu_sigma(0,2*pi,1,1);
%         lastError = [
%             r * cos(azimuth)
%             r * sin(azimuth)];
%         PoseUpdateTheta(:,i) = PoseUpdateTheta(:,i) +lastError;
%     end
%     plot(PoseUpdateTheta(1,:),PoseUpdateTheta(2,:),'lineWidth',2,'Color', grayColor)
% %     plot(PoseUpdateTheta(1,:),PoseUpdateTheta(2,:),'o','lineWidth',2,'Color', grayColor)
%     
%     
%     for i=1:1:length(POIStrip)
%         p=0;
%         for k=1:1:length(PoseUpdateTheta)
%             p = 1-(1-p)*(1-IsInspectPOI(PoseUpdateTheta(:,k),POIStrip(:,i),xc,radiusCircle,FOV));
%         end
%         M_execution(i) = M_execution(i)+p;
%     end
% end
% M_execution = M_execution./mc;

for i=1:1:length(xc)
plotCircle(xc(i),0,radiusCircle,100);

end
colorbar
xlabel('x[m]','fontsize',12)
ylabel('y[m]','fontsize',12)
%%
figure(1)
subplot(1,2,1)
hold on;grid on; box on;

commandpath = plot(VerticesLocationX,VerticesLocationY,'o--','linewidth',2,'color',[0 0 1,0.5]);
for i=1:1:length(VerticesLocationX)
r = 10;

teta = pi/2+FOV;
x = [VerticesLocation(1,i),VerticesLocation(1,i)+r *cos(teta)];
y = [VerticesLocation(2,i),VerticesLocation(2,i)+r *sin(teta)];
plot(x,y,'--','lineWidth',2,'color',[0 0 1,0.1]);
teta = pi/2-FOV;

x = [VerticesLocation(1,i),VerticesLocation(1,i)+r *cos(teta)];
y = [VerticesLocation(2,i),VerticesLocation(2,i)+r *sin(teta)];
plot(x,y,'--','lineWidth',2,'color',[0 0 1,0.1]);
end

xlim([-6.5 6.5]);
ylim([-4.5 POILocaitonY+0.5]);

grayColor = [0.1 .1 0.1,0.4];
mc = 50;
M_execution =zeros(length(POIStrip),1);

for j=1:1:mc
    PoseUpdateTheta = VerticesLocation;
    for i=1:1:length(PoseUpdateTheta)
        r = abs(rand_mu_sigma(0,1,1,1)*1);
        azimuth = rand_mu_sigma(0,2*pi,1,1);
        lastError = [
            r * cos(azimuth)
            r * sin(azimuth)];
        PoseUpdateTheta(:,i) = PoseUpdateTheta(:,i) +lastError;
    end
    plot(PoseUpdateTheta(1,:),PoseUpdateTheta(2,:),'Color', grayColor);
%     plot(PoseUpdateTheta(1,:),PoseUpdateTheta(2,:),'o','lineWidth',2,'Color', grayColor)
    
    
    for i=1:1:length(POIStrip)
        p=0;
        for k=1:1:length(PoseUpdateTheta)
            p = 1-(1-p)*(1-IsInspectPOI(PoseUpdateTheta(:,k),POIStrip(:,i),xc,radiusCircle,FOV));
        end
        M_execution(i) = M_execution(i)+p;
    end
end
M_execution = M_execution./mc;

% for i=1:1:length(xc)
% plotCircle(xc(i),0,radiusCircle,100);
% end

grayColor = [0.7 .7 0.5,1];
executionpath = plot(PoseUpdateTheta(1,:),PoseUpdateTheta(2,:),'o-','lineWidth',2,'Color', grayColor);
for i=1:1:length(PoseUpdateTheta)
r = 10;
teta = pi/2+FOV;
x = [PoseUpdateTheta(1,i),PoseUpdateTheta(1,i)+r *cos(teta)];
y = [PoseUpdateTheta(2,i),PoseUpdateTheta(2,i)+r *sin(teta)];
plot(x,y,'--','lineWidth',2,'Color', grayColor);
teta = pi/2-FOV;

x = [PoseUpdateTheta(1,i),PoseUpdateTheta(1,i)+r *cos(teta)];
y = [PoseUpdateTheta(2,i),PoseUpdateTheta(2,i)+r *sin(teta)];
plot(x,y,'--','lineWidth',2,'Color', grayColor);
end

%command-coverage
% Define x, f(x), and M(x)
x = POIStrip(1,:);
fUpper = (POILocaitonY+0.5)*ones(length(x),1);
fLower = POILocaitonY*ones(length(x),1);
% M = -x+7;
% Define the vertices: the points at (x, f(x)) and (x, 0)
N = length(x);
verts = [x(:), fUpper(:); x(:) fLower(:)];
% Define the faces to connect each adjacent f(x) and the corresponding points at y = 0.
q = (1:N-1)';
faces = [q, q+1, q+N+1, q+N];
p = patch('Faces', faces, 'Vertices', verts, 'FaceVertexCData', [M_execution(:); M_execution(:)], 'FaceColor', 'interp', 'EdgeColor', 'none');
uistack(p,'top');


for i=1:1:length(xc)
plotCircle(xc(i),0,radiusCircle,100);
end


% text(VerticesLocationX(1)+0.3,VerticesLocationY(1),'\pi^c','color',[0 0 1],'FontSize',14,'fontweight','bold')
% % text(PoseUpdateTheta(1,1)+0.3,PoseUpdateTheta(2,1)-0.2,'\Pi^e','color',grayColor,'FontSize',14,'fontweight','bold')
% text(2.5+0.3,-4.5-0.2,'\Pi^e','color',grayColor,'FontSize',14,'fontweight','bold')
% legend([commandpath,executionpath],'command-path','execution-paths','location','best')
uistack(executionpath,'top');
uistack(commandpath,'top');

xlim([-7.1 7.1])
ylim([-4.5 POILocaitonY+0.5])
xlabel('x[m]','fontsize',12)
ylabel('y[m]','fontsize',12)
% POIlocationX = VerticesLocationX;
% POIlocationY = 2*ones(1,length(POIlocationX));
% plot(POIlocationX,POIlocationY,'o','linewidth',2);
% cMap = interp1([0;1],[1 0 0; 0 1 0],linspace(0,1,256));
% cMap = cMap.^1.5;
% colormap(cMap)
% colorbar
                  % Confidence Intervals