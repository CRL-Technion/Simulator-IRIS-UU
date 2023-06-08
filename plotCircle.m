function  plotCircle(xc,yc,r,n)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
theta = (0:n-1)*(2*pi/n);
x = xc + r*cos(theta);
y = yc + r*sin(theta);
P = polyshape(x,y);
a = plot(P,'FaceColor','red','FaceAlpha',0.8);
% A = imread('cone.png');
% [L,W,D] = size(A);
% for i = 1:L
%   for j = 1:W
%       for k = 1:D
%           if A(i,j,k) == 0
%               A(i,j,k) = 255;
%           end
%       end
%   end
% end
% a = image(flipud(A), 'XData', [xc-0.7 xc+0.7], 'YData', [yc-0.8 yc+0.8]);
uistack(a,'top');
end

