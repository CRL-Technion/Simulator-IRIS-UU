close all
clear all
clc
%%
xc = [0,3,-3,6,-6];
radiusCircle = 1;
FOV = atan(0.5/5)+0.02;

figure1 = figure(1);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% subplot(1,2,1)
hold on;grid on; box on;

% pgon = polyshape([-1 -1 1 1], [-1 1 1 -1]);
% plot(pgon,'FaceColor','red','FaceAlpha',0.8);
% pgon = polyshape([-4 -4 -2 -2], [-1 1 1 -1]);
% plot(pgon,'FaceColor','red','FaceAlpha',0.8);
% pgon = polyshape([4 4 2 2], [-1 1 1 -1]);
% plot(pgon,'FaceColor','red','FaceAlpha',0.8);
% pgon = polyshape([-7 -7 -5 -5], [-1 1 1 -1]);
% plot(pgon,'FaceColor','red','FaceAlpha',0.8);
% pgon = polyshape([7 7 5 5], [-1 1 1 -1]);
% plot(pgon,'FaceColor','red','FaceAlpha',0.8);

VerticesLocationX = [4.5,1.5,-1.5,-4.5];
VerticesLocationY = -4*ones(1,length(VerticesLocationX));
VerticesLocation = [VerticesLocationX;VerticesLocationY];
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






% %execution-coverage
% % Define x, f(x), and M(x)
% fUpper = 3.5*ones(length(x),1);
% fLower = 3*ones(length(x),1);
% M = x+7;
% % Define the vertices: the points at (x, f(x)) and (x, 0)
% N = length(x);
% verts = [x(:), fUpper(:); x(:) fLower(:)];
% % Define the faces to connect each adjacent f(x) and the corresponding points at y = 0.
% q = (1:N-1)';
% faces = [q, q+1, q+N+1, q+N];
% p = patch('Faces', faces, 'Vertices', verts, 'FaceVertexCData', [M(:); M(:)], 'FaceColor', 'interp', 'EdgeColor', 'none')

x = [-7:0.01:7]';
POIStrip = [x,ones(length(x),1)*3]';


M_command =0;
for i=1:1:length(POIStrip)
    p=0;
    for j=1:1:length(VerticesLocation)
        p = 1-(1-p)*(1-IsInspectPOI(VerticesLocation(:,j),POIStrip(:,i),xc,radiusCircle,FOV));
    end
    M_command(i) = p;
end


% [aa,bb] =find(M_command>0.5);
% POIStrip = POIStrip(:,bb);
% M_command = M_command(bb);

grayColor = [0.7 .7 0.5,0.1];
mc = 100;
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
    plot(PoseUpdateTheta(1,:),PoseUpdateTheta(2,:),'lineWidth',2,'Color', grayColor)
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

grayColor = [0.7 .7 0.5,1];
executionpath = plot(PoseUpdateTheta(1,:),PoseUpdateTheta(2,:),'o-','lineWidth',2,'Color', grayColor)
for i=1:1:length(PoseUpdateTheta)
r = 10;
teta = pi/2+FOV;
x = [PoseUpdateTheta(1,i),PoseUpdateTheta(1,i)+r *cos(teta)];
y = [PoseUpdateTheta(2,i),PoseUpdateTheta(2,i)+r *sin(teta)];
plot(x,y,'--','lineWidth',2,'Color', grayColor)
teta = pi/2-FOV;

x = [PoseUpdateTheta(1,i),PoseUpdateTheta(1,i)+r *cos(teta)];
y = [PoseUpdateTheta(2,i),PoseUpdateTheta(2,i)+r *sin(teta)];
plot(x,y,'--','lineWidth',2,'Color', grayColor)
end

%command-coverage
% Define x, f(x), and M(x)
x = POIStrip(1,:);
fUpper = 3.5*ones(length(x),1);
fLower = 3*ones(length(x),1);
% M = -x+7;
% Define the vertices: the points at (x, f(x)) and (x, 0)
N = length(x);
verts = [x(:), fUpper(:); x(:) fLower(:)];
% Define the faces to connect each adjacent f(x) and the corresponding points at y = 0.
q = (1:N-1)';
faces = [q, q+1, q+N+1, q+N];
p_execution = patch('Faces', faces, 'Vertices', verts, 'FaceVertexCData', [M_execution(:); M_execution(:)], 'FaceColor', 'interp', 'EdgeColor', 'none')
uistack(p_execution,'top');

%command-coverage
% Define x, f(x), and M(x)
x = POIStrip(1,:);
fUpper = 3*ones(length(x),1);
fLower = 2.5*ones(length(x),1);
% M = -x+7;
% Define the vertices: the points at (x, f(x)) and (x, 0)
N = length(x);
verts = [x(:), fUpper(:); x(:) fLower(:)];
% Define the faces to connect each adjacent f(x) and the corresponding points at y = 0.
q = (1:N-1)';
faces = [q, q+1, q+N+1, q+N];
p_command = patch('Faces', faces, 'Vertices', verts, 'FaceVertexCData', [M_command(:); M_command(:)], 'FaceColor', 'interp', 'EdgeColor', 'none')
uistack(p_command,'top');

for i=1:1:length(xc)
plotCircle(xc(i),0,radiusCircle,100)
end


% Create textarrow
annotation('textarrow',[0.160069444444444 0.217013888888889],...
    [0.924553275976175 0.905360688285903]);

% Create textarrow
annotation('textarrow',[0.164236111111111 0.217708333333333],...
    [0.843150231634679 0.86168100595632]);

% Create textbox
annotation('textbox',...
    [0.0618388934092758 0.898063200815494 0.100324337763313 0.0723751274209991],...
    'String',{'Execution','coverage'},...
    'FontSize',12,...
    'FitBoxToText','on',...
    'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725]);

% Create textbox
annotation('textbox',...
    [0.0593978844589097 0.795107033639144 0.100324337763313 0.0723751274209991],...
    'String',{'Command','coverage'},...
    'FontSize',12,...
    'FitBoxToText','on',...
    'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725]);

legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.360716164903717 0.140866826853066 0.228234336859235 0.0823139653414883]);

% text(VerticesLocationX(1)+0.3,VerticesLocationY(1),'\pi^c','color',[0 0 1],'FontSize',14,'fontweight','bold')
% % text(PoseUpdateTheta(1,1)+0.3,PoseUpdateTheta(2,1)-0.2,'\Pi^e','color',grayColor,'FontSize',14,'fontweight','bold')
% text(2.5+0.3,-4.5-0.2,'\Pi^e','color',grayColor,'FontSize',14,'fontweight','bold')
legend([commandpath,executionpath],'command-path','execution-paths','location','best')
% legend([commandpath,executionpath,p_command,p_execution],'command-path','execution-paths','POI commnad','POI execution','location','best')

uistack(executionpath,'top');
uistack(commandpath,'top');

% x = [0.2 0.3];
% y = [0.8 0.85];
% annotation('textarrow',x,y,'String','POI command')
xlabel('x[m]','fontsize',12)
ylabel('y[m]','fontsize',12)
ax = gca; 
ax.FontSize = 16; 
xlim([-7.1 7.1])
ylim([-6 3.5])
% POIlocationX = VerticesLocationX;
% POIlocationY = 2*ones(1,length(POIlocationX));
% plot(POIlocationX,POIlocationY,'o','linewidth',2);
% cMap = interp1([0;1],[1 0 0; 0 1 0],linspace(0,1,256));
% cMap = cMap.^1.5;
% colormap(cMap)
colorbar
                  % Confidence Intervals