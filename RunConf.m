

%%
function RunConf(confName)
% load('appMembers.mat','S')
load(['Configuration/',confName,'.mat'],'S')

app = S.app;
event = S.event;
clear 'S'
RunEnvelopeButtonPushed(app, event)
end
function results = readEnvelopeInput(app,str)
input = str;
a= split(input,',');
values = 1;
indexValue = 0;
for i=1:1:length(a)
    b = split(a{i},':');
    for j=1:1:length(b)
        if length(strfind(a{i},':')) ==2
            initValue = str2double(b{1});
            jumpValue = str2double(b{2});
            finalValue = str2double(b{3});
            temp = [initValue:jumpValue:finalValue];
            if(indexValue>0)
                values = [values,temp];
            else
                values = [temp];
            end
            indexValue = indexValue+length(temp);
            
            break;
        else
            indexValue=indexValue+1;
            values(indexValue) = str2double(b{j});
        end
    end
end
results =values
end
% Value changed function: search_graphButton
function search_graphButtonValueChanged(app, event)
value = app.search_graphButton.Value;
IRIS_build_folder=app.IRISpathEditField.Value
CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];
file_to_read = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',app.file_to_readEditField.Value];
initial_p = app.initial_pEditField.Value;
initial_eps = app.initial_epsEditField.Value
tightening_rate = app.tightening_rateEditField.Value;
method= app.methodEditField.Value;

file_to_write = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',app.file_to_writeEditField.Value];
Location_error_parameter_file = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/','LocationErrorParameterFile'];
LocationErrorParameterFileName = 'LocationErrorParameterFile';

if ~exist([IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',LocationErrorParameterFileName])
    LocationErrorParameter = [...
        app.AccbiasmgEditField.Value,...
        app.GyrobiasdeghrEditField.Value,...
        app.AvaragevelocitymsEditField.Value,...
        app.MintimeinRZsEditField.Value,...
        app.MaxtimeinRZsEditField.Value,...
        app.MultipleFactorEditField.Value,...
        app.MonteCarloSearchEditField.Value];
    %10,10,1,MintimeallowedinGNSSOutageregionEnvelope(i),40,];
    
    WriteLocationErrorParameterFile([IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',LocationErrorParameterFileName],LocationErrorParameter);%
end
%             Location_error_parameter_file = 'LocationErrorParameterFile';
search_graph_input = ['./app/search_graph ',file_to_read,' ',num2str(initial_p),' ',num2str(initial_eps),' ',num2str(tightening_rate),' ',num2str(method),' ',file_to_write,' ',Location_error_parameter_file];

system([CommandToPowershell,search_graph_input])
end

% Value changed function: UAV_SimulationButton
function UAV_SimulationButtonValueChanged(app, event)
value = app.UAV_SimulationButton.Value;
file_to_write = app.InputIRISfilenameEditField.Value;
IRIS_build_folder=app.IRISpathEditField.Value;

OutputFolderName = [IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/'];
OutputFileName = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',app.OutputUAV_SimulationfilenameEditField.Value];
mainUAVsimulation;
end

% Value changed function: CheckPOIandCollisionButton
function CheckPOIandCollisionButtonValueChanged(app, event)
value = app.CheckPOIandCollisionButton.Value;

resultUAVSimulationFile = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',app.OutputUAV_SimulationfilenameEditField.Value,'_',app.InputIRISfilenameEditField.Value];
seed =app.seedEditField.Value;

IRIS_build_folder=app.IRISpathEditField.Value;
CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];

system([CommandToPowershell,'./app/checkPOIandCollision ',resultUAVSimulationFile,' ',seed])

end

% Value changed function: build_graphButton
function build_graphButtonValueChanged(app, event)
value = app.build_graphButton.Value;
IRIS_build_folder=app.IRISpathEditField.Value;
CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];

MonteCarloRunIRIS = 1;
if (isempty(app.counter))
    app.counter = 0;
end
file_to_write = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',app.filetowriteEditField.Value];
mkdircommand = ['mkdir -p  ','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter)];
system([CommandToPowershell,mkdircommand])

num_vertex = app.numvertesEditField.Value;
seed =app.seedEditField.Value;

build_graph_command = ['./app/build_graph ',num2str(seed),' ',num2str(num_vertex),' ',file_to_write];
system([CommandToPowershell,build_graph_command])
end

% Button pushed function: CreateTableResultButton
function CreateTableResultButtonPushed(app, event)
IRIS_build_folder=app.IRISpathEditField.Value;
%OutputFileName = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',app.OutputUAV_SimulationfilenameEditField.Value];

OutputFileName = ['Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',app.OutputUAV_SimulationfilenameEditField.Value,'_',app.InputIRISfilenameEditField.Value];
OutputFolderName = [IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/'];

load([OutputFolderName,'UAVSimulationResults']);
num_vertex = str2double(app.numvertesEditField.Value);
seed =str2double(app.seedEditField.Value);
initial_p = str2double(app.initial_pEditField.Value);
initial_eps = str2double(app.initial_epsEditField.Value);
tightening_rate = str2double(app.tightening_rateEditField.Value);
method= str2double(app.methodEditField.Value);
ResultFolder = [pwd,'\Results\'];
ResultFolder = [ResultFolder,app.OutputTableresultfoldernameEditField.Value];
%             a =datestr((now));
%             OutputFolderTemp = [ResultFolder,a(1:11),'_'];
%             temp = split(a(13:end),':');
%             OutputFolder = [OutputFolderTemp,temp{1},temp{2},temp{3}];


OutputFolder = ResultFolder;
%             if ~exist(OutputFolder, 'dir')
%                 mkdir(OutputFolder)
%             end
CurrentFoler = app.CurrentFoler;
%             load('UAVSimulationResults')
CreateTableResults;
if ~isempty(app.CurrentFoler)
    app.CurrentFoler= [];
end
end

% Button pushed function: RunallprocessButton
function RunallprocessButtonPushed(app, event)
app.counter = 0;
IRIS_build_folder=app.IRISpathEditField.Value;
CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];
mkdircommand = ['mkdir -p ','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter)];
system([CommandToPowershell,mkdircommand])
%build_graph
build_graphButtonValueChanged(app, event);
%search_graph
search_graphButtonValueChanged(app, event);
%uav simualtion
UAV_SimulationButtonValueChanged(app, event);
%checkPOIandCollision
CheckPOIandCollisionButtonValueChanged(app, event);
%Create table results
app.CurrentFoler= [];
CreateTableResultButtonPushed(app, event);
end

% Button pushed function: RunEnvelopeButton
function RunEnvelopeButtonPushed(app, event)
MintimeallowedinGNSSOutageregionEnvelope = readEnvelopeInput(app,app.MintimeallowedinGNSSOutageregionEditField.Value);
MaxtimeallowedinGNSSOutageregionEnvelope = readEnvelopeInput(app,app.MaxtimeallowedinGNSSOutageregionEditField.Value);
MonteCarloSearchEnvelope = readEnvelopeInput(app,app.MonteCarloSearchEnvelopeEditField.Value);
IRIS_build_folder=app.IRISpathEditField.Value;
LocationErrorParameterFileName = 'LocationErrorParameterFile';
%Run build_graph
is_Graph_build = 0;
app.counter =0;

for MC_search_id =1:1:length(MonteCarloSearchEnvelope)
    for i=1:1:length(MintimeallowedinGNSSOutageregionEnvelope)
        for i_max=1:1:length(MaxtimeallowedinGNSSOutageregionEnvelope)
            %                         app.counter = length(MaxtimeallowedinGNSSOutageregionEnvelope)*(i-1)+i_max;
            app.counter = app.counter+1;
            IRIS_build_folder=app.IRISpathEditField.Value;
            CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];
            mkdircommand = ['mkdir -p  ','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter)];
            system([CommandToPowershell,mkdircommand])
            %Location Error Parameter
            LocationErrorParameter = [...
                app.AccbiasmgEditField.Value,...
                app.GyrobiasdeghrEditField.Value,...
                app.AvaragevelocitymsEditField.Value,...
                MintimeallowedinGNSSOutageregionEnvelope(i),...%app.MintimeinRZsEditField.Value,...
                MaxtimeallowedinGNSSOutageregionEnvelope(i_max),...%app.MaxtimeinRZsEditField.Value,...
                app.MultipleFactorEditField.Value,...
                MonteCarloSearchEnvelope(MC_search_id)];
            %10,10,1,MintimeallowedinGNSSOutageregionEnvelope(i),40,];
            
            WriteLocationErrorParameterFile([IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter),'/',LocationErrorParameterFileName],LocationErrorParameter);%
            app.seedEditField.Value = num2str(i);
            
            CurrentOutputFolder = ['\runNumber',num2str(i)];
            ResultFolder = [pwd,'\Results\'];
            OutputFolder = [ResultFolder,app.OutputTableresultfoldernameEditField.Value];
            pathBuildGraphFolder = [IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(0)];
            %                     if ~exist([OutputFolder,CurrentOutputFolder], 'dir')
            %                         mkdir([OutputFolder,CurrentOutputFolder])
            %                     end
            app.CurrentFoler = CurrentOutputFolder;
            if (~is_Graph_build)
                
                pathBuildGraphFolder = [IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(0)];
                %                         if ~isfile([pathBuildGraphFolder,'/',app.filetowriteEditField.Value,'_conf']) %build was not performed in another thread
                
                if (~isfile([pathBuildGraphFolder,'/CheckBuildStarted']))
                    if ~exist(pathBuildGraphFolder, 'dir')
                        mkdir(pathBuildGraphFolder);
                    end
                    fileID = fopen([pathBuildGraphFolder,'/CheckBuildStarted'],'w');
                    fclose(fileID);
                    app.counter = 0;
                    build_graphButtonValueChanged(app, event);
                    %                                 app.counter = length(MaxtimeallowedinGNSSOutageregionEnvelope)*(i-1)+i_max;
                    app.counter =1;
                    fileID = fopen([pathBuildGraphFolder,'/CheckBuildEnded'],'w');
                    fclose(fileID);
                else
                    while (~isfile([pathBuildGraphFolder,'/CheckBuildEnded'])) % search was not ended in the first thread
                        pause(3);
                    end
                end
                
                %                         build_graphButtonValueChanged(app, event);
                is_Graph_build = 1;
            end
            %                  if (counter>2)
            %                             break;
            %                         end
            for j=1:1:(app.IRISMonteCarlonumberEditField.Value)
                %build_graph
                %                     build_graphButtonValueChanged(app, event);
                %search_graph
                pathBuildGraphFolder = [IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(0)];
                pathCurrentFolder = [IRIS_build_folder,'/','Results/',app.OutputTableresultfoldernameEditField.Value,'/Run',num2str(app.counter)];
                tryNotSuceess = 1;
                while(tryNotSuceess)
                    try
                        copyfile([pathBuildGraphFolder,'/',app.filetowriteEditField.Value,'_conf'],[pathCurrentFolder,'/']);
                        copyfile([pathBuildGraphFolder,'/',app.filetowriteEditField.Value,'_edge'],[pathCurrentFolder,'/']);
                        copyfile([pathBuildGraphFolder,'/',app.filetowriteEditField.Value,'_vertex'],[pathCurrentFolder,'/']);
                        %                                 copyfile([pathBuildGraphFolder,'/',app.filetowriteEditField.Value,'_poiVertex'],[pathCurrentFolder,'/']);
                        
                        tryNotSuceess = 0;
                    catch
                        pause(1);
                    end
                end
                %                             copyfile([IRIS_build_folder,'\',app.file_to_writeEditField.Value],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %                             copyfile([IRIS_build_folder,'\',app.file_to_writeEditField.Value,'_result'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                if ~isfile([pathCurrentFolder,'/CheckSearchStarted']) %search was not performed in another thread
                    if ~exist(pathCurrentFolder, 'dir')
                        mkdir(pathCurrentFolder);
                    end
                    fileID = fopen([pathCurrentFolder,'/CheckSearchStarted'],'w');
                    fclose(fileID);
                    search_graphButtonValueChanged(app, event);
                    
                    temp = importdata([pathCurrentFolder,'/testIRIS']);
                    nosolution = (temp(end,5) < temp(end,2)*temp(end,3)); %noSolution
                    %                             if (nosolution)
                    %                                 continue;
                    %                             end
                    fileID = fopen([pathCurrentFolder,'/CheckSearchEnded'],'w');
                    fclose(fileID);
                else
                    continue;
                    %                             while (~isfile([pathCurrentFolder,'/CheckSearchEnded'])) % search was not ended in the first thread
                    %                                 pause(3);
                    %                             end
                end
                
                
                %                         if (j==1)
                %                             mkdir([OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %                             copyfile([IRIS_build_folder,'\',LocationErrorParameterFileName],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %                             copyfile([IRIS_build_folder,'\',app.file_to_writeEditField.Value],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %                             copyfile([IRIS_build_folder,'\',app.file_to_writeEditField.Value,'_result'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %                             copyfile([IRIS_build_folder,'\',app.filetowriteEditField.Value,'_conf'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %                             copyfile([IRIS_build_folder,'\',app.filetowriteEditField.Value,'_edge'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %                             copyfile([IRIS_build_folder,'\',app.filetowriteEditField.Value,'_vertex'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\'])
                %
                %                         end
                for k=1:1:(app.SimulationMonteCarlonumberEditField.Value)
                    %uav simualtion
                    
                    file_to_write = app.InputIRISfilenameEditField.Value;
                    %
                    UAV_SimulationButtonValueChanged(app, event);
                    %checkPOIandCollision
                    CheckPOIandCollisionButtonValueChanged(app, event);
                    %Create table results
                    app.CurrentFoler = CurrentOutputFolder;
                    
                    CreateTableResultButtonPushed(app, event);
                    %                             app.counter=app.counter+1;
                    %                            Command = InitCommand(file_to_write,IRIS_build_folder);
                    %                         POI_belong_region;
                    %                         totalOptimalPOIIRIS = length(unique([WCovRegion_POI_SearchSpace,WOutagesRegion_POI_SearchSpace]));
                    %                         totalOptimalPOISimulation = length(unique([WOutagesRegion_POI_palnned,WCovRegion_POI_palnned]));
                    %                         if (totalOptimalPOISimulation<totalOptimalPOIIRIS)
                    %                             break;
                    %                         end
                    %                             //if (k==1)
                    %                                 SimulationOutputFileName = app.OutputUAV_SimulationfilenameEditField.Value;
                    %                                 IRISOutputFileName = app.filetowriteEditField.Value;
                    %                                 copyfile([IRIS_build_folder,'\',SimulationOutputFileName,'_',IRISOutputFileName],[OutputFolder,CurrentOutputFolder,'\IRISOutput\']);
                    %                                 copyfile([IRIS_build_folder,'\',SimulationOutputFileName,'_',IRISOutputFileName,'_edge'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\']);
                    %                                 copyfile([IRIS_build_folder,'\',SimulationOutputFileName,'_',IRISOutputFileName,'_vertex'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\']);
                    %                                 copyfile([pwd,'\','UAVSimulationResults.mat'],[OutputFolder,CurrentOutputFolder,'\IRISOutput\']);
                    
                    
                    %                             //end
                end
            end
            
        end
    end
end
end

% Button pushed function: PlotEnvelopeResultButton
function PlotEnvelopeResultButtonPushed(app, event)
folderDir = app.PathoftheenveloperesultEditField.Value;
PostProcessResultFromFolder;
end