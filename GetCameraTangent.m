function CameraTangent = GetCameraTangent(PsiConfig,CameraAngleConfig)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    Zrotation = [cos(PsiConfig),-sin(PsiConfig),0;...
                sin(PsiConfig),cos(PsiConfig),0;
                0,0,1];
    Yrotation = [cos(CameraAngleConfig),0,sin(CameraAngleConfig);...
                0,1,0;
                -sin(CameraAngleConfig),0,cos(CameraAngleConfig)]; 


    CameraTangent = Zrotation * Yrotation * [1,0,0]'; 
%     CameraTangent = [cos(PsiConfig)*cos(CameraAngleConfig),sin(PsiConfig)*cos(CameraAngleConfig),-sin(CameraAngleConfig)]';
end

