% Change the current folder to the folder of this m-file.
% 
% if(~isdeployed)
%   cd(fileparts(which(mfilename)));
% end
addpath InitFunction
addpath ServiceFunction
addpath Control
addpath Command
addpath PostProcess
addpath StepFunction

% SimplifiedMotionModel;
% return;
%
% pause(0.3)
% 
% Command = InitCommand(file_to_write,OutputFolderName);
% PoseUpdateTheta = Command.Pose_des_GF;
% 
% % noise = 1.5;
% % 
% %   State.X = Command.Pose_des_GF(1,1:3)';
% %     if (checkGPSAvailable(State))
% %                     r = abs(rand_mu_sigma(0,1,1,1)*1);
% %     else
% %                     r = abs(rand_mu_sigma(0,1,1,1)*3);
% %     end
% %                azimuth = rand_mu_sigma(0,2*pi,1,1);
% %             elevation = rand_mu_sigma(0,2*pi,1,1);
% % lastError = [
% %     r * cos(elevation) * cos(azimuth)
% % r * cos(elevation) * sin(azimuth)
% % -r * sin(elevation)];
% for i=2:1:length(Command.Pose_des_GF(:,1))
%     State.X = Command.Pose_des_GF(i,1:3)';
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
% fileName = fopen([IRIS_build_folder,'\',OutputFileName,'_',file_to_write],'w');
% % fileName = fopen([OutputFileName,'_',file_to_write],'w');
% % Writing data to file
% fprintf(fileName, '%f %f %f %f %f\n', PoseUpdateTheta');
% % Closing
% fclose(fileName)
% 
% ScenarioParameter = InitScenario;
% IMUParameters = InitIMU(ScenarioParameter);
% Quad = InitQuad;
% Control = InitControl;
% Command = InitCommand(file_to_write,OutputFolderName);
% 
% [State,Command] = InitState(IMUParameters,Command,ScenarioParameter.ScenarioMode);
% [NavState,Command] = InitNavState(Command,State,ScenarioParameter);
% 
% Command.PoseSimulation = [State.X',State.psi,State.theta,NavState.theta,0];
% 
% EKF = InitEKF(NavState,IMUParameters,ScenarioParameter);
% DynamicStateParameter = InitDynamic(ScenarioParameter,State);
% SensorMeas = GetSensorMeas(DynamicStateParameter,IMUParameters);
% DynamicNavStateParameter = UpdateNavDynamic(SensorMeas,NavState);
% State = UpdateTrueIMUBias(SensorMeas,DynamicStateParameter,State);
% 
% 
% InitRecordParameter;%[RecordState,RecordNavState,RecordEKF,RecordCommand,RecordScenarioParameter]= InitRecordParameter(State,NavState,EKF,1);
% time = 0;
% t = 0;
% Path_Length = 0;
% length_in_location_error = 0;
% time_in_location_error = 0;
% temp_length_in_location_error=0;
% temp_time_in_location_error = 0;
% 
% save([OutputFolderName,'UAVSimulationResults'],'RecordState','RecordNavState','RecordScenarioParameter','RecordCommand','RecordEKF'...
%     ,'Command','length_in_location_error','Path_Length','IMUParameters','ScenarioParameter','time_in_location_error')
% return;

%% Init
ScenarioParameter = InitScenario;
IMUParameters = InitIMU(ScenarioParameter);
Quad = InitQuad;
Control = InitControl;
Command = InitCommand(file_to_write,OutputFolderName);

[State,Command] = InitState(IMUParameters,Command,ScenarioParameter.ScenarioMode);
[NavState,Command] = InitNavState(Command,State,ScenarioParameter);

Command.PoseSimulation = [State.X',State.psi,State.theta,NavState.theta,0];

EKF = InitEKF(NavState,IMUParameters,ScenarioParameter);
DynamicStateParameter = InitDynamic(ScenarioParameter,State);
SensorMeas = GetSensorMeas(DynamicStateParameter,IMUParameters);
DynamicNavStateParameter = UpdateNavDynamic(SensorMeas,NavState);
State = UpdateTrueIMUBias(SensorMeas,DynamicStateParameter,State);


InitRecordParameter;%[RecordState,RecordNavState,RecordEKF,RecordCommand,RecordScenarioParameter]= InitRecordParameter(State,NavState,EKF,1);
time = 0;
t = 0;
Path_Length = 0;
length_in_location_error = 0;
time_in_location_error = 0;
temp_length_in_location_error=0;
temp_time_in_location_error = 0;


%% Step
for i=1:1:(ScenarioParameter.FinalTime/ScenarioParameter.dt)
    
    %   Update State
    State = UpdateState(ScenarioParameter,State,DynamicStateParameter.f_b,DynamicStateParameter.w_b);
    NavState = UpdateNavState(ScenarioParameter,NavState,DynamicNavStateParameter.f_b,DynamicNavStateParameter.w_b,IMUParameters);
    
    %   EKF update
    ScenarioParameter.isGPSAvailable = checkGPSAvailable(State);
    
    if (ScenarioParameter.IdealIMU==0)
        [NavState,EKF] = EKFStep(ScenarioParameter,NavState,State,DynamicNavStateParameter,EKF,i);
    end
    
    if (ScenarioParameter.ScenarioMode>0)% not static
        %   Implement Controller
        Control = UpdateControl(Control,NavState,Command.X_des_GF,Command.psi_des,DynamicNavStateParameter,Quad,ScenarioParameter.g,ScenarioParameter.dt);
        Control.init=1;
    end
    %   DynamicsAndKinematic
    DynamicStateParameter = UpdateDynamic(ScenarioParameter,DynamicStateParameter,State,Control,Quad,time);
    SensorMeas = GetSensorMeas(DynamicStateParameter,IMUParameters);
    DynamicNavStateParameter = UpdateNavDynamic(SensorMeas,NavState);
    State = UpdateTrueIMUBias(SensorMeas,DynamicStateParameter,State);
    
    if (Command.Finish_pose_command )
        break;
    end
    if (ScenarioParameter.isGPSAvailable)
        timeInRiskZone = 0;
    else
        timeInRiskZone = time_in_location_error(end);
    end
    if (ScenarioParameter.ScenarioMode>0)% not static
        
        [Command,Control]=UpdateCommandAndInitlizeControl(State,Command,Control,NavState,ScenarioParameter.ScenarioMode,i,timeInRiskZone);
    end
    %         checkPOI;%Command = checkPOI(State,Environment,Command);
    %         CheckCollision;%Environment= CheckCollision(Environment,State,time);
    
    %Record
    RecordParameter
    if (i>1)
        additional_path_length = norm(RecordState.X(:,i)-RecordState.X(:,i-1));
        Path_Length = Path_Length + additional_path_length;
        
        if (ScenarioParameter.isGPSAvailable==0)
            if (RecordScenarioParameter.isGPSAvailable(:,i-1) == 1)
                if(length_in_location_error(1)<1e-6)
                    length_in_location_error = temp_length_in_location_error;
                else
                    length_in_location_error = [length_in_location_error,temp_length_in_location_error];
                end
                temp_length_in_location_error = 0;
            end
            temp_length_in_location_error =temp_length_in_location_error+additional_path_length;
            
        end
        if (Command.Finish_pose_command && ScenarioParameter.isGPSAvailable==0 &&RecordScenarioParameter.isGPSAvailable(:,i-1) == 0)
            if(length_in_location_error(1)<1e-6)
                length_in_location_error = temp_length_in_location_error;
            else
                length_in_location_error = [length_in_location_error,temp_length_in_location_error];
            end
        end
        
        
        
        if (ScenarioParameter.isGPSAvailable==0)
            if (RecordScenarioParameter.isGPSAvailable(:,i-1) == 1)
                if(time_in_location_error(1)<1e-6)
                    time_in_location_error = temp_time_in_location_error;
                else
                    time_in_location_error = [time_in_location_error,temp_time_in_location_error];
                end
                temp_time_in_location_error = 0;
            end
            temp_time_in_location_error =temp_time_in_location_error+ScenarioParameter.dt;
            
        end
        if (Command.Finish_pose_command && ScenarioParameter.isGPSAvailable==0 &&RecordScenarioParameter.isGPSAvailable(:,i-1) == 0)
            if(time_in_location_error(1)<1e-6)
                time_in_location_error = temp_time_in_location_error;
            else
                time_in_location_error = [time_in_location_error,temp_time_in_location_error];
            end
        end
        
    end
    
    
    time = time+ScenarioParameter.dt;
    
end
%% Output
time = t;
thetaTrueSimulation = Command.PoseSimulation(:,5);
thetaNavSimulation = Command.PoseSimulation(:,6);
% thetaCamera = Command.Pose_des_GF(:,5) -  thetaNavSimulation + thetaTrueSimulation;
% PoseUpdateTheta = [Command.PoseSimulation(:,1:4),thetaCamera];%thetaCamera];
PoseUpdateTheta = [Command.PoseSimulation(:,1:3),Command.Pose_des_GF(:,4:5)];%thetaCamera];
fileName = fopen([IRIS_build_folder,'\',OutputFileName,'_',file_to_write],'w');
% fileName = fopen([OutputFileName,'_',file_to_write],'w');
% Writing data to file
fprintf(fileName, '%f %f %f %f %f\n', PoseUpdateTheta');
% Closing
fclose(fileName)

save([OutputFolderName,'UAVSimulationResults'],'RecordState','RecordNavState','RecordScenarioParameter','RecordCommand','RecordEKF'...
    ,'Command','length_in_location_error','Path_Length','IMUParameters','ScenarioParameter','time_in_location_error')