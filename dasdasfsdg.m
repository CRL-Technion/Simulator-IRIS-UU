syms a b c d e f g h 
eq1 = 	a*e+b*g== -e*a-f*c;
eq2 = 		a*f+b*h== -e*c-f*d;
eq3 = 		c*e+d*g== -g*a-h*c;
eq4 = 		c*f+d*h== -g*b-h*d;

solu = solve ([eq1,eq2,eq3,eq4],[a,b,c,d,e,f,g,h],'Real',false)
% eq5 = a*e+b*g == c11;
% eq6 = a*f+b*h == c12;
% eq7 = c*e+d*g == c21;
% eq8 = c*f+d*h == c22;
%%
CD = cell(1,1);
for i=1:length(solu.a)
    CD{i} = [solu.a(i),solu.b(i);solu.c(i),solu.d(i)]*[solu.e(i),solu.f(i);solu.g(i),solu.h(i)];
    CD{i}
end
%%
[solu.a,solu.b,solu.c,solu.d,solu.e,solu.f,solu.g,solu.h]

%%
clc
C = [0,1;-1,0];
D = [-1,1;1,1];
C*D
-D*C

%%
A = [0,1;-1,0];
A*A