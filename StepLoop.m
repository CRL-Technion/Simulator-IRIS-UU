%Update State
    UpdateState;
    UpdateNavState;
%     State = UpdateState(ScenarioParameter,State,DynamicStateParameter.f_b,DynamicStateParameter.w_b);
%     NavState = UpdateNavState(ScenarioParameter,NavState,DynamicNavStateParameter.f_b,DynamicNavStateParameter.w_b,IMUParameters);
    
    %EKF update
    EKFStep;
%     [NavState,EKF] = EKFStep(ScenarioParameter,NavState,State,DynamicNavStateParameter,EKF,i);
    
    % Implement Controller
%     position_PID;
%     attitude_PID;
%     rate_PID;
    
    % Calculate Desired Motor Speeds
%     quad_motor_speed;
    
    % DynamicsAndKinematic
%     DynamicStateParameter = UpdateDynamic(ScenarioParameter,DynamicParameter,State,Quad,t(i));
%     SensorMeas = GetSensorMeas(DynamicStateParameter,IMUParameters);
%     DynamicNavStateParameter = UpdateNavDynamic(SensorMeas,NavState);
%     State = UpdateTrueIMUBias(SensorMeas,DynamicStateParameter,State);
UpdateDynamic;
GetSensorMeas;
UpdateNavDynamic;    
UpdateTrueIMUBias;
%         if (Quad.Finish_pose_command || Quad.t_plot(Quad.counter-1)>=Quad.sim_time)
%         break;
%         end
%     update_pose_des;
%         Quad.POIChecked = checkPOI(Quad.POIChecked);
%     CheckCollision
  
    %record
    RecordParameter
  
%     [RecordState,RecordNavState,RecordEKF] = RecordParameter(State,NavState,EKF,i,RecordState,RecordNavState,RecordEKF);