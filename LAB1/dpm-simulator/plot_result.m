
data = dlmread('result.txt');

% Extract columns for plotting
timeout_values = data(:, 1);
total_energy_values = data(:, 2);

% Plot the data
figure;
scatter(timeout_values, total_energy_values, 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'g');
xlabel('Timeout Values');
ylabel('Total Energy');
title('DPM Simulation Results');
grid on;

%plot_result to call the script in matlab