function [p,n] = findKappaGiven_lb_and_m(lb_des,n,alpha,isFind_n_min)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if (isFind_n_min)
    
    p=0.999;
    xn = p*n;
    nu1 = 2*xn;
    nu2 = 2*(n-xn+1);
    F   = finv(alpha/2,nu1,nu2);
    lb  = (nu1.*F)./(nu2 + nu1.*F);
    while(lb<(lb_des-1e-3))
        n=n+1;
        xn = p*n;
        nu1 = 2*xn;
        nu2 = 2*(n-xn+1);
        F   = finv(alpha/2,nu1,nu2);
        lb  = (nu1.*F)./(nu2 + nu1.*F);
%         if (lb>lb_des)
%             break;
%         end
    end
else
    p=0.999;
    xn = p*n;
    nu1 = 2*xn;
    nu2 = 2*(n-xn+1);
    F   = finv(alpha/2,nu1,nu2);
    lb  = (nu1.*F)./(nu2 + nu1.*F);
    while(lb>lb_des)
        p=p-0.001;
        xn = p*n;
        nu1 = 2*xn;
        nu2 = 2*(n-xn+1);
        F   = finv(alpha/2,nu1,nu2);
        lb  = (nu1.*F)./(nu2 + nu1.*F);
        if (lb<lb_des)
            break;
        end
    end
end
end
