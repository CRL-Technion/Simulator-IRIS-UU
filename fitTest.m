function fitTest(data)
%% Section 1
%%%%%%%%%%%%%%%%%%%%%%%%%%% Define plot options %%%%%%%%%%%%%%%%%%%%%%%%%%%
ExtrapolatedDistance = 0; % extrapolated distance of the curve
ScreenHeight = 1080; % pixel
ScreenWidth  = 1920; % pixel
WindowHeight = 1080; % pixel
WindowWidth  = 1080; % pixel
FontName = 'Times New Roman';
FontSize = 18;
LineWidth = 2;
%% Section 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Read data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example data
% data = [50, 2.763 ; ...
%     100, 3.252 ; ...
%     150, 3.478 ; ...
%     200, 3.638 ; ...
%     250, 3.767 ; ...
%     260, 3.791 ; ...
%     270, 3.814 ; ...
%     280, 3.836 ; ...
%     290, 3.857 ; ...
%     298, 3.874 ; ...
%     300, 3.878 ; ...
%     310, 3.899 ; ...
%     320, 3.919 ; ...
%     330, 3.936 ; ...
%     340, 3.958 ; ...
%     350, 3.977 ; ...
%     360, 3.995 ; ...
%     370, 4.013 ; ...
%     380, 4.031 ; ...
%     390, 4.048 ; ...
%     400, 4.065 ; ...
%     450, 4.147 ; ...
%     500, 4.222 ; ...
%     550, 4.293 ; ...
%     600, 4.358 ; ...
%     650, 4.420 ; ...
%     700, 4.479 ; ...
%     750, 4.534 ; ...
%     800, 4.586 ; ...
%     850, 4.636 ; ...
%     900, 4.684 ; ...
%     950, 4.729 ; ...
%     1000, 4.773 ; ...
%     1050, 4.814 ; ...
%     1100, 4.854 ; ...
%     1200, 4.930 ; ...
%     1300, 5.000 ; ...
%     1400, 5.065 ; ...
%     1500, 5.126 ; ...
%     1600, 5.184 ; ...
%     1700, 5.238 ; ...
%     1800, 5.290 ; ...
%     1900, 5.339 ; ...
%     2000, 5.385 ; ...
%     2100, 5.430 ; ...
%     2200, 5.472 ; ...
%     2300, 5.513 ; ...
%     2400, 5.552 ; ...
%     2500, 5.589 ; ...
%     2600, 5.626 ; ...
%     2700, 5.660 ; ...
%     2800, 5.694 ; ...
%     2900, 5.727 ; ...
%     3000, 5.758 ; ...
%     3100, 5.789 ; ...
%     3200, 5.818 ; ...
%     3300, 5.847 ; ...
%     3400, 5.875 ; ...
%     3500, 5.902 ; ...
%     3600, 5.928 ; ...
%     3700, 5.954 ; ...
%     3800, 5.979 ; ...
%     3900, 6.003 ; ...
%     4000, 6.027 ; ...
%     4100, 6.051 ; ...
%     4200, 6.073 ; ...
%     4300, 6.096 ; ...
%     4400, 6.117 ; ...
%     4500, 6.139 ; ...
%     5000, 6.239];
% data = readmatrix('example.txt'); % read from a file
x = data(:,1);
y = data(:,2);
org(:,1) = x; % original x
org(:,2) = y; % original y
mu = mean(x); % average
sigma = std(x); % standard deviation
SStot = sum((data(:,2) - mean(org(:,2))).^2); % explained sum of squares
%% Section 3
%%%%%%%%%%%%%%%%%%%%%%%% Prepare data for fitting %%%%%%%%%%%%%%%%%%%%%%%%%
step = 1; % Skipping some values might help with fitting.
x = x(1:step:end);
y = y(1:step:end);
extrapolate = 1;
if extrapolate == 1 % Helps with bad extrapolating qualities.
    % Not always necessary, so skip this section if not needed.
    % Adjust points and step if needed.
    
    points_end = 25;  % extra points to the end
    step = mean(diff(org(:,1)));
    a = max(x) + step;
    b = a + step*points_end;
    p = polyfit(x(end-2:end),y(end-2:end),1); % linear correlation
    x0end = a:step:b;
    y0end = polyval(p,x0end);
    x = [x ; x0end'];
    y = [y ; y0end'];
    points_start = 5; % extra points to the start
    step = min(diff(org(:,1)));
    a = min(x) - step*points_start;
    b = min(x) - step;
    p = polyfit(x(1:2),y(1:2),1); % linear correlation
    x0start = a:step:b;
    y0start = polyval(p,x0start);
    x = [x0start' ; x];
    y = [y0start' ; y];
end
%% Section 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prepare model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R2_target = 0.9999; % target accuracy of the fit, R2target <= 1
iter_lim = 200; % stop iteration if R2 has not improved during this number
format longG % best format for copying the function
% Protected common functions are below. Add more if needed.
common_fun = ["exp", "log", "sin", "cos", "tan", "sqrt", "pi"];
% Fit options
normalize = 'off'; % 'on', 'off'
robust = 'off'; % 'off', 'LAR', 'Bisquare'
exclude = x < -Inf; % exclude data if necessary
% Function
d = 16; % maximum number of digits in the coefficients
prefix = 'p'; % prefix of the coefficients
indep = {'x'}; % cell containing independent variables
fun = 'p1+p2*x+p3*exp(p4+p5/x+p6*log(x)+p7*x^p8)'; % custom
% List of some commonly used functions
% fun = 'exp(p1+p2/x)'; % Andrade
% fun = 'exp(p1+p2/x+p3*x+p4*x^2+p5*x^3)'; % Extended Andrade
% fun = 'exp(p1+p2/(x+p3))'; % Vogel
% fun = 'exp(p1+p2/x+p3*log(x)+p4*x^p5)'; % DIPPR 101
% fun = 'p1*x^p2/(1+p3/x+p4/x^2)'; % DIPPR 102
% fun = ['p5*exp(p1*(-((x-p3)/(x-p4))^(1/3))+',...
%           'p2*(-((x-p3)/(x-p4))^(1/3)*((p3-x)/(x-p4))))']; % PPDS 9
% fun = '10^(p1-p2/(x+p3))'; % Antoine
% fun = 'p1+p2*x+p3*x^2+p4*x^3+p5/x^2'; % Shomate
% fun = 'p1+p2*(x/p6)+p3*(x/p6)^2+p4*(x/p6)^3+p5*(x/p6)^4'; % Polynomial
% Coefficient names (prefix + number)
names = fun;
for i = common_fun
    names = strrep(names,i,''); % remove common functions
end
names = unique(regexp(names,strcat(prefix,'\d*'),'Match'));
% If you prefer naming without prefix, create names vector as follows
% names = {'a','b','c'}
% Fit type
ft = fittype(fun,'independent',indep,'coefficients',names);
% List of some library models for curves:
% poly1, rat34, exp1, fourier1, gauss1, sin1, power1
% More information at:
% https://se.mathworks.com/help/curvefit/list-of-library-models-for-curve-
% and-surface-fitting.html
% If you use library models, you can simply define fit type as follows
% ft = 'poly4';
%% Section 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signs = ['*', '/', '^']; % signs
R2_max = -Inf; % R2 max initialization
R2 = 0; % R2 initialization
fail = 0; % consecutive fail counter initializatio
iter = 0; % iteration counter initialization
test = 1; % test flag  
while R2 < R2_target
    try
        if test == 1 % Do test fit.
            f = fit(x,y,ft,'Normalize',normalize,'Robust',robust,...
                'Exclude',exclude);
            test = 0;
        else % Do new fit with bounds.
            f = fit(x,y,ft,'Normalize',normalize,'Robust',robust,...
                'Exclude',exclude,'StartPoint',2.*rand(1,n)-1,'Lower',...
                lower,'Upper',upper);
        end
    catch
        % Sometimes fitting fails even if the model was correct.
        % This happens more often if Robust is used. Reason is usually
        % that the coefficient lower and upper bounds should be tightened.
        fail = fail+1;
        if fail > 1000
            disp(['Error using fit. Too many failed fits in a row. ', ...
                'Check data, function and fit options.'])
            f = fit(x,y,ft,'Normalize',normalize,'Robust',robust,...
                'Exclude',exclude); % run the function to see the error
            break
        else
            test = 1;
            continue
        end
    end
    fail = 0; % fail counter reset
    iter = iter+1; % count the succesful iterations
    fun = regexprep(string(formula(f)),'[\n\r ]+',''); % symbolic function
    values = coeffvalues(f); % coefficient values
    if iter == 1 % Names and handle.
        names = coeffnames(f); % coefficients
        indep = indepnames(f); % independent variables
        n = numel(names);
        m = numel(indep);
        handle = '@('; % function handle
        for i = 1:m
            if i < m
                handle = strcat(handle,indep{i},',');
            else
                handle = strcat(handle,indep{i});
            end
        end
        handle = strcat(handle,')');
    end
    
    for i = common_fun % Protect common functions.
        fun = strrep(fun,i,num2str(reshape(dec2bin(char(i),8),1,[])));
    end
    
    for i = 1:n % Swap variable names with their values.
        fun = strrep(fun,names{i},num2str(values(i),d));
    end
    
    for i = signs % Make the function work with vectors.
        fun = strrep(fun,i,strcat('.',i));
    end
     
    if string(normalize) == "on" % Normalize independent variables.
        for i = 1:m
            fun = strrep(fun,indep{i},strcat('((',indep{i},'-',...
                num2str(mu(i),d),')./',num2str(sigma(i),d),')'));
        end
    end
    for i = common_fun % Convert common functions back to strings.
        fun = strrep(fun,reshape(dec2bin(char(i),8),1,[]),i);
    end
    
    fun = str2func(strcat(handle,char(fun))); % Matlab function
    SSres = sum((org(:,2)-fun(org(:,1))).^2); % residual sum of squares
    R2 = 1 - SSres/SStot; % coefficient of determination
    R2(R2 > 1 || isnan(R2)) = -Inf; % set unreal values as -Inf
    
    if R2 > R2_max || iter == 1 % Update the model.
        f_max = f;
        fun_max = fun;
        R2_max = R2;
        values_max = values';
        iter_max = iter;
        lower = -abs(values)-mu(1); % lower bound
        upper = abs(values)+mu(1); % upper bound
    end
    
    clc % Print newest iteration results.
    fprintf('Iter = %d\n', iter)
    fprintf('R2 = %f\n', R2)
    fprintf('R2 max = %f\n\n', R2_max)
    
    if iter-iter_max > iter_lim % Exit when R2 does not change.
        fprintf(['Early exit: R2 has not improved in ', ...
            num2str(iter_lim), ' iterations.\n\n'])
        break
    end
end
%% Section 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Display results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:numel(names) % coefficients
    disp([names{i}, ' = ', num2str(values_max(i),d)])
end
fun = string(regexprep(string(formula(f_max)),'[\n\r ]+',''));
if string(normalize) == "on" % normalization
    fprintf('\n')
    for i = 1:m
        fun = strrep(fun,indep{i},strcat('((',indep{i},'-',...
            'mu_',indep{i},')/','sigma_',indep{i},')'));
        disp(['mu_', indep{i}, ' = ', num2str(mu(i),d)])
        disp(['sigma_', indep{i}, ' = ', num2str(sigma(i),d)])
    end
end
fprintf('\nf = %s\n', fun) % symbolic function
fprintf('\nf = %s\n\n', char(fun_max)) % Matlab function
figure('Name','fit',...
        'DefaultAxesFontName',FontName, ...
        'DefaultTextFontName',FontName, ...
        'DefaultAxesFontSize',FontSize, ...
        'numbertitle', 'off', ...
        'color', 'w', ...
        'outerposition', [(ScreenWidth-WindowWidth)/2, ...
        (ScreenHeight-WindowHeight)/2, WindowWidth WindowHeight])
hold on; grid on; title('Curve Fitting Tool')
xlabel('x'); ylabel('y')
step = min([mean(diff(x)),1]); % step for drawing the curve
% ExtrapolatedDistance = 20000;
if ExtrapolatedDistance <= max(x)
    x1 = x(1):step:x(end);
else
    x1 = x(1):step:ExtrapolatedDistance;
end
plot(x1,fun_max(x1),'b-','LineWidth',LineWidth) % fitted curve
plot(org(:,1),org(:,2),'r*','LineWidth',LineWidth) % data
legend('fitted curve','data','location','best'); hold off; 
end