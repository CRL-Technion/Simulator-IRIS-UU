m=500000;
n = 120;
p = 0.04;
r = binornd(n,p,m,1)/100;
nbins = 17; % number of bins
histogram(r, nbins, 'Normalization', 'probability')
box on; grid on; 
xlabel('Collision probability of ')
ylabel('Number of occurs')

percentile95 = prctile(r,97.5); % calculate the 95th percentile
hold on; % hold the plot
line([percentile95 percentile95], get(gca, 'YLim'), 'Color', 'r', 'LineWidth', 2); % add line for 95th percentile
hold off; % release the plot
percentile95 = prctile(r,2.5); % calculate the 95th percentile
hold on; % hold the plot
line([percentile95 percentile95], get(gca, 'YLim'), 'Color', 'r', 'LineWidth', 2); % add line for 95th percentile
hold off; % release the plot



xlabel('$\hat{\mathcal{C}}(\pi_i)$','Interpreter','latex');
ylabel('Probability Density');
legend('Estimation collision probability','97.5th Percentile', '2.5th Percentile');
xlim([0 0.12])