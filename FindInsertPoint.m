function [insertPoint,isInsert] = FindInsertPoint(target,source)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
isInsert=false;
insertPoint = zeros(1,3);
X = [-25,25];
Y = [-1,1];
Z = [-20,20];
LowerBordersXYZ = [X(1),Y(1),Z(1)];
UpperBordersXYZ = [X(2),Y(2),Z(2)];

   direction = (target - source);
   normVec = norm(direction);
   direction = direction/normVec;
     t = (LowerBordersXYZ - source)./direction;
     t = [t,(UpperBordersXYZ - source)./direction];
      sort(t,'descend');
      
      for i=1:1:length(t)
          if (t(i) > 0 && t(i) < normVec)
              insertPoint = source + (t(i)+0.01)*direction;
               State.X = insertPoint;
                if (checkGPSAvailable(State)==0)
                    isInsert = true;
                    return;
                end
              
          end
      end
end

