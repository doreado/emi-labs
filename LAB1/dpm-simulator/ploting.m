
% 74.3 ms: tbe idle
% 1    ms: tbe sleep
fileName = 'part1_1.txt';
tbe = 0.8;
part_plots(tbe, fileName, 1, 1);

fileName = 'part2_1.txt';
tbe = 74.3;
part_plots(tbe, fileName, 1, 2);

fileName = 'part1_2.txt';
tbe = 0.8;
part_plots(tbe, fileName, 2, 1);

fileName = 'part2_2.txt';
tbe = 74.3;
part_plots(tbe, fileName, 2, 2);

function [] =part_plots(tbe, fileName, workload_num, part_num)
format long;
dataFilePath = [ 'results', filesep, fileName ];
data = readtable(dataFilePath, 'HeaderLines', 0);
if part_num == 1
    name = 'idle';
else 
    name = 'sleep';
end
name = [num2str(workload_num), '-', name];

% normalized version
% timeout_plot(tbe, data.timeout, (data.total_energy_no_dpm - data.total_energy) / data.total_energy_no_dpm, 'Saved Energy');
timeout_plot(tbe, data.timeout, data.total_energy_no_dpm - data.total_energy, [name, ' Saved Energy']);
% timeout_plot(tbe, data.timeout, data.total_energy, [name, ' Total Energy']);
% timeout_plot(tbe, data.timeout, data.total_time, [name, ' Total Time']);
timeout_plot(tbe, data.timeout, data.total_time - data.total_time_no_dpm, [name, ' Performance Loss']);
end

function []= timeout_plot(tbe, x, y, y_name)
figure;
plot(x, y, '-', 'MarkerSize', 12);
xline(tbe, 'r--');
title(y_name);
xlabel('Timeout');
ylabel(y_name);
grid on;
end
