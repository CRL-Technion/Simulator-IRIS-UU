function [lb] = SumlowerBoundFunction(p,n,alpha,kappa,I)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% p1= kappa*I -(sum(p));
% p = [p1;p];
% xn = p*n;
% p1= kappa*I -(sum(p));
% p = [p1;p];

% p(1) = 0.5;
% p(2:9) =0.9+0.4/8;
xn = p*n;


nu1 = 2*xn;
nu2 = 2*(n-xn+1);
F   = finv(alpha/2,nu1,nu2);
lb  = (nu1.*F)./(nu2 + nu1.*F);
% xeq0 = find(xn == 0);
% if ~isempty(xeq0)
%     lb(xeq0) = 0;
% end
% sumLb = sum(lb);

% 
% xeq0 = isnan(lb);
% if xeq0(1)==1
%     lb(1) = 0;
% end





% Upper limits
% nu1 = 2*(xn+1);
% nu2 = 2*(n-xn);
% F   = finv(1-alpha/2,nu1,nu2);
% ub = (nu1.*F)./(nu2 + nu1.*F);
% sumLb = sum(ub);
end

