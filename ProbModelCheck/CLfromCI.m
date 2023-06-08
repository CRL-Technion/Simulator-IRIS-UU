function [CL] = CLfromCI(CI,n,p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% p = 0:0.1:1;
% n = 0:1:300;
figure(1)
hold on;grid on;box on;
% h =cell(1,1);
% cellLegend = cell(1);
CL = zeros(length(p),length(n));
for i=1:1:length(p)
    sigma =1;
%     for k=1:1:length(n)
%          if(p(i)>=0.1 && p(i)<=0.9 && n(k)*p(i) >5 && n(k)*(1-p(i)) >5) 
%             sigma(k) = sqrt(n(k)./(p(i)*(1-p(i))));
%          else
%             sigma(k) = sqrt(n(k)./p(i));
%          end
% 
%     end
    sigma = sqrt(n./(p(i)*(1-p(i))));
    z = CI*sigma;
    for j=1:1:length(z)
         temp = normcdf([-z(j) z(j)]);
         CL(i,j) = temp(2)-temp(1);


    end
end
end

