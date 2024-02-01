format long;
fileName = 'workload_2.txt';
dataFilePath = [ 'example', filesep, fileName ];
data = load(dataFilePath);
disp(data(2:end, 1) - (data(1:end-1, 1) + data(1:end-1, 2)))
figure;
% plot(data(1:end-1,2), data(2:end, 1) - (data(1:end-1, 1) + data(1:end-1, 2)), '.', 'MarkerSize', 12);
histogram(data(2:end, 1) - (data(1:end-1, 1) + data(1:end-1, 2)));
title(y_name);
xlabel('Active Times');
ylabel('Idle Times');
grid on;


% t = 29.8790976000 - 0.5983824530