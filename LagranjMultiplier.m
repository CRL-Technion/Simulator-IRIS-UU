 clc
 clear all
 close all
  I = 30; %size of POI
 alpha = 0.05;
mc = [10:1:300];
p = [0.95:0.01:1];
 ci_lower = zeros(length(mc),length(p));
index=0;
for i_mc = 1:1:length(mc)
    for i_p=1:1:length(p)
        n = mc(i_mc); %number of MC
        kappa = p(i_p); 
        fun = @(p)SumlowerBoundFunction(p,n,alpha,kappa,I);
p0 = ones(I,1);

A = -ones(I,1)';
B = -kappa*I;
Aeq = [];
Beq = [];
LB = zeros(I,1);
UB = ones(I,1);
[x,fval,exitflag,output] = fmincon(fun,p0,A,B,Aeq,Beq,LB,UB);
        ci_lower(i_mc,i_p) = fval/I;
    end
end

contourf((mc),(p)*100,ci_lower')

colorbar
ax = gca;
ax.CLim(2) =100;
newmap = jet;                    %starting map
ncol = size(newmap,1);           %how big is it?
zpos = 1 + floor(2/3 * ncol);    %2/3 of way through
newmap(zpos,:) = [1 1 1];        %set that position to white
colormap(newmap);                %activate it
title('CI lower bound coverage')
xlabel('# Monte Carlo')
ylabel('\kappa')

% p0 = ones(I-1,1)*kappa;
% p0 = ones(I-1,1);

% options = optimset('PlotFcns',@optimplotfval);
% options = optimset('PlotFcns','optimplotfval','TolX',1e-7);

% [p,fval,exitflag,output]= fminsearch(fun,p0);
% p1= kappa*I -(sum(p));
% p = [p1;p]
% fval/I
%
% A = ones(I,1)';
% B = kappa*I;
% p0 = ones(I-1,1)*kappa;

% fval/I
%%
close all
  I = 30; %size of POI
   alpha = [0.1,0.05];
  for i_alpha=1:1:length(alpha)
%       subplot(3,1,i_alpha)
f = figure
hold on;grid on;box on
 
  n = [10,100,1000,10000]; %number of MC
   kappa = 0.9; 
   p=[0:0.01:1];
   lb=1;
   for j=1:1:length(n)
   for i=1:1:length(p)
       lb(i) = SumlowerBoundFunction(p(i),n(j),alpha(i_alpha),kappa,I);

   end
%      figure(1)
%    hold on;grid on; box on
%    plot(p,lb)
%    figure(2)
%   hold on;grid on; box on
   x = p;
   y = lb;
    % this is the "finite difference" derivative. Note it is  one element shorter than y and x
 yd = diff(y)./diff(x);
 % this is to assign yd an abscissa midway between two subsequent x
 xd = (x(2:end)+x(1:(end-1)))/2;
 
 yd_2 = diff(yd)./diff(xd);
 xd_2 = (xd(2:end)+xd(1:(end-1)))/2;
 % this should be a rough plot of your derivative
 plot(xd_2,yd_2,'LineWidth',2)
   end

% title('$\frac{\partial^2 \hat{p}^-(\hat{p}_j^{\pi_u},m,\alpha)}{\partial^2 \hat{p}_j^{\pi_u}}$ Vs $\hat{p}_j^{\pi_{u}}$. , $\alpha = 0.1$','Fontsize',12,'Interpreter','latex')
xlabel('$\hat{p}_j^{\pi_{u}}$','Fontsize',12,'Interpreter','latex')
ylabel('$\frac{\partial^2 \hat{p}^-(\hat{p}_j^{\pi_u},m,\alpha)}{\partial^2 \hat{p}_j^{\pi_u}}$','Fontsize',12,'Interpreter','latex')
  f.Position = [100 100 250 250];
  end
 legend('m=10','m=100','m=1000','m=10000');
 %%
   I = 30; %size of POI
   alpha = [0.1,0.05];
  for i_alpha=1:1:length(alpha)
%       subplot(3,1,i_alpha)
f = figure
hold on;grid on;box on
 
  n = [10,100,1000,10000]; %number of MC
   kappa = 0.9; 
   p=[0:0.01:1];
   lb=1;
   for j=1:1:length(n)
   for i=1:1:length(p)
       lb(i) = SumlowerBoundFunction(p(i),n(j),alpha(i_alpha),kappa,I);

   end
%      figure(1)
%    hold on;grid on; box on
%    plot(p,lb)
%    figure(2)
%   hold on;grid on; box on
   x = p;
   y = lb;
    % this is the "finite difference" derivative. Note it is  one element shorter than y and x
 yd = diff(y)./diff(x);
 % this is to assign yd an abscissa midway between two subsequent x
 xd = (x(2:end)+x(1:(end-1)))/2;
 
%  yd_2 = diff(yd)./diff(xd);
%  xd_2 = (xd(2:end)+xd(1:(end-1)))/2;
 % this should be a rough plot of your derivative
 plot(xd,yd,'LineWidth',2)
   end

% title('$\frac{\partial^2 \hat{p}^-(\hat{p}_j^{\pi_u},m,\alpha)}{\partial^2 \hat{p}_j^{\pi_u}}$ Vs $\hat{p}_j^{\pi_{u}}$. , $\alpha = 0.1$','Fontsize',12,'Interpreter','latex')
xlabel('$\hat{p}_j^{\pi_{u}}$','Fontsize',12,'Interpreter','latex')
ylabel('$\frac{\partial \hat{p}^-(\hat{p}_j^{\pi_u},m,\alpha)}{\partial \hat{p}_j^{\pi_u}}$','Fontsize',12,'Interpreter','latex')
  f.Position = [100 100 250 250];
  end