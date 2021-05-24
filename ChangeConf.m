function ChangeConf(confName)
% load('appMembers.mat','S')
 temp = load(['Configuration/',confName,'.mat'])





while(1)
    try
        a = temp.UI.app.UIFigure.Name;
        pause(1);
    catch
        break;
    end
end
a=1;
end