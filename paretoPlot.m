clc
clear all
close all
ipv_num = 50;
figure(1)
hold on; grid on; box on;
CL = 0.95;
alpha = 1-CL;
mc = [20:1:300];
p = [0.9:0.01:1];
ci_lower = zeros(length(mc),length(p));
index=0;
for i_mc = 1:1:length(mc)
    for i_p=1:1:length(p)
        x =p(i_p)*ones(mc(i_mc),1);
%         [phat,pci] = binofit((sum(x)),length(x),alpha);
        index = index+1;
%         ci_lower(i_mc,i_p) = pci(1)*100;
%         ci_lower(i_mc,i_p)  = 100*(1- betainv(1-alpha/2,(length(x)-sum(x)),(sum(x))+1));
        kappa = 1;I=1;
        
        ci_lower(i_mc,i_p) = 100*SumlowerBoundFunction(p(i_p), mc(i_mc),alpha,kappa,I);
    end
    ci_lower(i_mc,:) = smooth(smooth(smooth(ci_lower(i_mc,:))));
end
contourf((mc),(p),ci_lower',[65:5:90,93,97],'ShowText','on')

colorbar
ax = gca;
ax.CLim(2) =100;
newmap = jet;                    %starting map
ncol = size(newmap,1);           %how big is it?
zpos = 1 + floor(2/3 * ncol);    %2/3 of way through
newmap(zpos,:) = [1 1 1];        %set that position to white
colormap(newmap);                %activate it
% title('CI lower bound coverage percentage')

h = colorbar;
% set(get(h,'title'),'string','$\min \frac{\vert \bar{\mathcal{S}}({\pi}_{u}) \vert}{k}[\%]$','Interpreter','latex');
plot([70 70],[0.9,0.99],'k--','linewidth',2);
plot([20 70],[0.99,0.99],'k--','linewidth',2);
xlabel('$m$','interpreter','latex', 'FontWeight','bold','fontsize',16)
ylabel('$\kappa$','interpreter','latex', 'FontWeight','bold','fontsize',16)

annotation('textarrow',[0.2 0.23],...
    [0.93 0.85]);
text(73,0.99,'$\hat{p}^-(\kappa,m,\alpha) = 93[\%]$','Interpreter','latex','FontWeight','bold','fontsize',16)

cbh = colorbar;
cbh.Ticks = [65:5:90,93,95]; 
caxis([65,95]);
ax = gca;
ax.FontSize = 14; 
%%
figure(2)
hold on; grid on; box on;
ipv_num = 50;

CL = 0.95;
alpha = 1-CL;
mc = [20:1:300];
p = [0:0.01:0.05];
ci_lower = zeros(length(mc),length(p));
index=0;
for i_mc = 1:1:length(mc)
    for i_p=1:1:length(p)
        x =p(i_p);
%         [phat,pci] = binofit((sum(x)),length(x),alpha);
        index = index+1;
%         ci_lower(i_mc,i_p) = pci(2)*100;
        
        xn = x*mc(i_mc);%p*n;
        n = mc(i_mc);
        nu1 = 2*(xn+1);
        nu2 = 2*(n-xn);
        F   = finv(1-alpha/2,nu1,nu2);
        ub = (nu1.*F)./(nu2 + nu1.*F);
        ci_lower(i_mc,i_p) = ub*100;
%         ci_lower(i_mc,i_p)  = 100*(1- betainv(1-alpha/2,(length(x)-sum(x)),(sum(x))+1));
    end
    ci_lower(i_mc,:) = smooth(smooth(smooth(ci_lower(i_mc,:))));
end
contourf((mc),(p),ci_lower',[0,3,4,7,10,15,20],'ShowText','on')

colorbar
ax = gca;
% ax.CLim(2) =100;
newmap = jet;                    %starting map
ncol = size(newmap,1);           %how big is it?
zpos = 1 + floor(2/3 * ncol);    %2/3 of way through
newmap(zpos,:) = [1 1 1];        %set that position to white
colormap(newmap);                %activate it
% title('CI upper bound of collision probability')
h = colorbar;
% set(get(h,'title'),'string','$\max \bar{\mathcal{C}}(\pi){_{,u}}$','Interpreter','latex');

plot([94 94],[0.0,0.02],'k--','linewidth',2);
plot([20 94],[0.02,0.02],'k--','linewidth',2)
xlabel('$m$','interpreter','latex', 'FontWeight','bold','fontsize',16)
ylabel('$\rho_{coll}$','interpreter','latex', 'FontWeight','bold','fontsize',16)


annotation('textarrow',[0.26 0.29],...
    [0.5 0.45]);
text(98,0.0195,'$\hat{p}^+(\rho_{coll},m,\alpha) = 7[\%]$','Interpreter','latex','FontWeight','bold','fontsize',16)

% annotation('textarrow',[0.2 0.25],...
%     [0.93 0.85]);
% text(73,0.99,'$\vert \bar{\mathcal{S}}^-({\pi}_{u}) \vert = 93[\%]$','Interpreter','latex','FontWeight','bold','fontsize',16)
% 
cbh = colorbar;
cbh.Ticks = [0,5,7,10:5:25]; 
caxis([0,25]); 
oldcmap = colormap;
colormap( flipud(oldcmap) );
ax = gca;
ax.FontSize = 14; 