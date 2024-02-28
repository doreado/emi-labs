digitizer();
%% 
p = load(['./to_digitalize/pv_dcdc.txt']);
figure

voltages = format(p(:,1));
eff = format(p(:,2));

disp(voltages);
disp(eff);