dataFilePath = 'C:\Users\marco\OneDrive\Documenti\emi-labs\LAB1\dpm-simulator\results\result1_1000_10.txt';
data = readtable(dataFilePath, 'HeaderLines', 0);

timeout = data(1:2:end, 1);
totalEnergy = data(2:2:end, 11);
timeout = table2array(timeout);
totalEnergy = table2array(totalEnergy);

figure;
%plot(timeout, totalEnergy, 'o-', 'LineWidth', 2, 'MarkerSize', 15, 'MarkerFaceColor', 'auto');
plot(timeout, totalEnergy, '.','MarkerSize', 15);
title('Timeout-Total Energy');
xlabel('Timeout');
ylabel('Total Energy');
grid on;