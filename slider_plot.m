function [] = slider_plot()
Folder = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build\';

Search_process = cell(1,1);
fid = fopen([Folder,'Search_process_file']);
tline = fgets(fid);
index = 1;
Search_process{index} = str2num(tline);
while ischar(tline);
    prevLine = tline;
    tline = fgets(fid);
    if (ischar(tline))
        index = index+1;
        Search_process{index} = str2num(tline);
    end
    if index >50000
        break;
    end
    
end
fclose(fid);
testIRIS_conf = importdata([Folder,'testIRIS_conf']);

S.testIRIS_conf = testIRIS_conf;
S.Search_process = Search_process;

% Plot different plots according to slider location.
% S.fh = figure('units','pixels',...
%     'position',[300 300 300 300],...
%     'menubar','none',...
%     'name','slider_plot',...
%     'numbertitle','off',...
%     'resize','off');
S.fh = figure(1)
hold on
tolerance = 0.5;
xmin = -100-tolerance;
xmax = 100+tolerance;
ymin=-22-tolerance;
ymax =2+tolerance;
zmin = -20-tolerance;
zmax = 0+tolerance;

plot3([xmin xmax xmax xmin xmin],[ymin ymin ymax ymax ymin],[zmin zmin zmin zmin zmin],'k')
plot3([xmin xmax xmax xmin xmin],[ymin ymin ymax ymax ymin],[zmax zmax zmax zmax zmax],'k')


plot3([xmin xmax xmax xmin xmin],[ymin ymin ymin ymin ymin],[zmin zmin zmax zmax zmin],'k')
plot3([xmin xmax xmax xmin xmin],[ymax ymax ymax ymax ymax],[zmin zmin zmax zmax zmin],'k')

plot3([xmin xmin xmin xmin xmin],[ymin ymax ymax ymin ymin],[zmin zmin zmax zmax zmin],'k')
plot3([xmax xmax xmax xmax xmax],[ymin ymax ymax ymin ymin],[zmin zmin zmax zmax zmin],'k')

plot3([xmax xmax xmax xmax xmax],[ymin ymax ymax ymin ymin],[zmin zmin zmax zmax zmin],'k')
plot3([xmax xmax xmax xmax xmax],[ymin ymax ymax ymin ymin],[zmin zmin zmax zmax zmin],'k')
S.x = S.testIRIS_conf(1,1);
S.y = S.testIRIS_conf(1,2);
S.z = S.testIRIS_conf(1,3);
% S.x = 0:.01:1;  % For plotting.
% S.ax = axes('unit','pix',...
%     'position',[20 80 260 210]);
% S.ax = axes();
S.LN = plot3(S.x,S.y,S.z,'r');
sliderMin = 1;
sliderMax = length(S.Search_process);
% S.sl = uicontrol('style','slide',...
%     'unit','pix',...
%     'position',[20 10 260 30],...
%     'min',sliderMin,'max',sliderMax,'val',1,...
%     'sliderstep',[1, 1] / (sliderMax - sliderMin),...
%     'callback',{@sl_call,S});
S.sl = uicontrol('style','slide',...
    'unit','pix',...
    'position',[330 200 200 30],...
    'min',sliderMin,'max',sliderMax,'val',1,...
    'sliderstep',[1, 1] / (sliderMax - sliderMin),...
    'callback',{@sl_call,S});
xlim([xmin-10 xmax+10])
ylim([ymin-10 ymax+10])
zlim([zmin-10 zmax+10])
view(0,90)
hold off
Node = S.Search_process(1);

textToDisplay = {'Information:-----------------------------',...
        ['Index - ',num2str(Node{1}(1))],...
    ['ParentIndex - ',num2str(Node{1}(2))],...
    ['GhostCost - ',num2str(Node{1}(3))],...
    ['CostToCome - ',num2str(Node{1}(4))],...
    ['GhostCoverageSize - ',num2str(Node{1}(5))],...
    ['CoverageSize - ',num2str(Node{1}(6))],...
    ['CostToComeRiskZone - ',num2str(Node{1}(7))]};
% text(x_txt, y_txt,textToDisplay );

S.l = legend(textToDisplay,'location','bestoutside');
% S.t = annotation('textbox');
% S.t.String = textToDisplay;
% S.t.Position = S.l.Position;
% S.t.LineStyle = 'None';

function [] = sl_call(varargin)
% Callback for the slider.
tolerance = 0.5;
xmin = -100-tolerance;
xmax = 100+tolerance;
ymin=-22-tolerance;
ymax =2+tolerance;
zmin = -20-tolerance;
zmax = 0+tolerance;

[h,S] = varargin{[1,3]};  % calling handle and data structure.
get(h,'value')
Node = S.Search_process(round(get(h,'value')));
% Node = S.Search_process(169);

PathIndex = Node{1}(8:end)+1;
S.x = S.testIRIS_conf(PathIndex,1);
S.y = S.testIRIS_conf(PathIndex,2);
S.z = S.testIRIS_conf(PathIndex,3);
set(S.LN,'xdata',S.x,'ydata',S.y,'zdata',S.z)
xlim([xmin-10 xmax+10])
ylim([ymin-10 ymax+10])
zlim([zmin-10 zmax+10])
% view(0,90)
%%

axlim = get(gca, 'XLim');                                           % Get ‘XLim’ Vector
aylim = get(gca, 'YLim');                                           % Get ‘YLim’ Vector
x_txt = min(axlim) + 5 ;      % Set ‘x’-Coordinate Of Text Object
y_txt = min(aylim) + 5 ;      % Set ‘y’-Coordinate Of Text Object
textToDisplay = {'Information:-----------------------------',...
    ['Index - ',num2str(Node{1}(1))],...
    ['ParentIndex - ',num2str(Node{1}(2))],...
    ['GhostCost - ',num2str(Node{1}(3))],...
    ['CostToCome - ',num2str(Node{1}(4))],...
    ['GhostCoverageSize - ',num2str(Node{1}(5))],...
    ['CoverageSize - ',num2str(Node{1}(6))],...
    ['CostToComeRiskZone - ',num2str(Node{1}(7))]};
% text(x_txt, y_txt,textToDisplay );
S.l = legend(textToDisplay,'location','bestoutside');
% l = legend(textToDisplay);
% t = annotation('textbox');
% t.String = textToDisplay;
% t.Position = l.Position;
% t.LineStyle = 'None';
% plotquarter(xmin,xmax,ymin,ymax,zmin)
% plotquarter(xmin,xmax,ymin,ymax,zmax)
% plotquarter(xmin,xmax,zmin,zmax,ymin)
% plotquarter(xmin,xmax,zmin,zmax,ymax)
% plotquarter(ymin,ymax,zmin,zmax,xmin)
% plotquarter(ymin,ymax,zmin,zmax,xmax)
%%