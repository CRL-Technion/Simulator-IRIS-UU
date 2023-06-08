function [isInspect] = IsInspectPOI(source,target,xc,radiusCircle,FOV)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if(norm(target-source)>10)
    isInspect = 0;
    return;
end
diff = target-source;
teta = atan2(diff(2),diff(1));
if (abs(teta-pi/2) > FOV)
    isInspect = 0;
    return;
end
slope = (target(2)-source(2))/(target(1)-source(1));
intersect = -slope*source(1)+source(2);
for i=1:1:length(xc)
    [xout,yout] = linecirc(slope,intersect,xc(i),0,radiusCircle);
    if (~isnan(xout))
        isInspect = 0;
        return;
    end
end
isInspect = 1;

end

