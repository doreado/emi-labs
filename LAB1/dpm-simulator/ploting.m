format long
fileName = 'result2_1000_0.1.txt';
dataFilePath = [ 'results', filesep, fileName ];
data = readtable(dataFilePath, 'HeaderLines', 0);

figure;
plot(data.timeout, data.total_energy, '.','MarkerSize', 12, 'MarkerFaceColor', 'auto');
title('Timeout-Total Energy');
xlabel('Timeout');
ylabel('Total Energy');
grid on;
 
figure;
plot(data.timeout, data.total_time, '.', 'MarkerSize', 12);
title('Timeout-Total Time');
xlabel('Timeout');
ylabel('Total Time');
grid on;