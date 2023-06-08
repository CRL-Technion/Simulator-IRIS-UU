%%%%%%%%randomVarOfIMU;
% OutputFolderName = '\\wsl.localhost\Ubuntu-20.04\home\davidalpert\Projects\IRIS\build\Results\SimplifiedM_without_insert\Run2\';
% file_to_write = 'testIRIS';
milli_g2mpss = 9.81 / 1000.0;                 %   Conversion from [mili g ] to [m/s^2]
degPerHr2radPerSec = (3.14 / 180.0) / 3600.0; %  Conversion from [deg/hr] to [rad/s]
b_a_milli_g =(10);
b_g_degPerHr =(10);
b_a = (b_a_milli_g * milli_g2mpss);
b_g = (b_g_degPerHr * degPerHr2radPerSec);
ba_x = rand_mu_sigma(0,sqrt(b_a),1,1);
ba_y = rand_mu_sigma(0,sqrt(b_a),1,1);
ba_z = 0;%rand_mu_sigma(0,sqrt(b_a),1,1);
bg_x = rand_mu_sigma(0,sqrt(b_g),1,1);
bg_y = rand_mu_sigma(0,sqrt(b_g),1,1);
bg_z = rand_mu_sigma(0,sqrt(b_g),1,1);

Command = InitCommand(file_to_write,OutputFolderName);
PoseUpdateTheta = Command.Pose_des_GF;
previousTotalLocationError = zeros(3,1);
perviousTimeRiskZone = 0;
for i=1:1:length(Command.Pose_des_GF)
    if (i>1)
        parentPosition = Command.Pose_des_GF(i-1,1:3);
        parentPosition_fix = parentPosition+previousTotalLocationError';
    end
    childPosition = Command.Pose_des_GF(i,1:3);
    childPosition_fix = childPosition+previousTotalLocationError';
    State.X = childPosition_fix;
%         State.X = childPosition;

    if (checkGPSAvailable(State) || i==1)
        r = abs(normrnd(0,1,1,1));
        azimuth =  normrnd(0,2*pi,1,1); 
        elevation = normrnd(0,2*pi,1,1);
        previousTotalLocationError = [
            r * cos(elevation) * cos(azimuth)
            r * cos(elevation) * sin(azimuth)
            -r * sin(elevation)];
        childPosition_fix = childPosition + previousTotalLocationError';
        perviousTimeRiskZone = 0;
    else
        State.X = parentPosition_fix;
%         State.X = parentPosition;

        if (checkGPSAvailable(State))
            
            [parentPosition_fix_temp,isInsert] = FindInsertPoint(childPosition_fix,parentPosition_fix);
            if(isInsert)
                parentPosition_fix = parentPosition_fix_temp;
            end
            %%todo calculate insertpoint
        end
        currentTimeRiskZone = perviousTimeRiskZone + norm(childPosition_fix-parentPosition_fix);
        
        
        temp_x_error = ba_x * (1.0 / 2.0) * (currentTimeRiskZone * currentTimeRiskZone - perviousTimeRiskZone * perviousTimeRiskZone);
        temp_x_error = temp_x_error + (1.0 / 6.0) * (currentTimeRiskZone * currentTimeRiskZone * currentTimeRiskZone - perviousTimeRiskZone * perviousTimeRiskZone * perviousTimeRiskZone) * (-bg_z + bg_y);
        
        temp_y_error = ba_y * (1.0 / 2.0) * (currentTimeRiskZone * currentTimeRiskZone - perviousTimeRiskZone * perviousTimeRiskZone);
        temp_y_error = temp_y_error + (1.0 / 6.0) * (currentTimeRiskZone * currentTimeRiskZone * currentTimeRiskZone - perviousTimeRiskZone * perviousTimeRiskZone * perviousTimeRiskZone) * (bg_z - bg_x);
        
        g = 9.81;
        temp_z_error = ba_z * (1.0 / 2.0) * (currentTimeRiskZone * currentTimeRiskZone - perviousTimeRiskZone * perviousTimeRiskZone);
        temp_z_error = temp_z_error+(1.0 / 6.0) * (currentTimeRiskZone * currentTimeRiskZone * currentTimeRiskZone - perviousTimeRiskZone * perviousTimeRiskZone * perviousTimeRiskZone) * (-bg_y + bg_x) * (-g);
        
        diffPosition = childPosition_fix-parentPosition_fix;
%         [psi,theta,r] = cart2sph(diffPosition(1),diffPosition(2),diffPosition(3));
        psi = atan2(diffPosition(2),diffPosition(1));
        theta = -atan2(diffPosition(3),norm([diffPosition(1),diffPosition(2)]));
        
        previousTotalLocationError(1) = previousTotalLocationError(1) + cos(theta) * cos(psi) * temp_x_error - sin(psi) * temp_y_error + sin(theta) * cos(psi) * temp_z_error;
        previousTotalLocationError(2) = previousTotalLocationError(2) + cos(theta) * sin(psi) * temp_x_error + cos(psi) * temp_y_error + sin(theta) * sin(psi) * temp_z_error;
        previousTotalLocationError(3) = previousTotalLocationError(3) -sin(theta) * temp_x_error + cos(theta) * temp_z_error;
        
        
        childPosition_fix = childPosition + previousTotalLocationError';
        
        perviousTimeRiskZone = perviousTimeRiskZone+norm(childPosition_fix-parentPosition_fix);
        
    end
    PoseUpdateTheta(i,1:3) = childPosition_fix;
end

fileName = fopen([IRIS_build_folder,'\',OutputFileName,'_',file_to_write],'w');
% fileName = fopen([OutputFileName,'_',file_to_write],'w');
% Writing data to file
fprintf(fileName, '%f %f %f %f %f\n', PoseUpdateTheta');
% Closing
fclose(fileName)

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

% save([OutputFolderName,'UAVSimulationResults'],'PoseUpdateTheta','RecordState','RecordNavState','RecordScenarioParameter','RecordCommand','RecordEKF'...
%     ,'Command','length_in_location_error','Path_Length','IMUParameters','ScenarioParameter','time_in_location_error')
% pause(1)