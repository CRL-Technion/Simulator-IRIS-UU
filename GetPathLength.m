function [PathLength] = GetPathLength(Path)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
PathLength = 0;
for i=1:1:length(Path(:,1))-1
    PathLength = PathLength + norm(Path(i,1:3)-Path(i+1,1:3));
end

end

