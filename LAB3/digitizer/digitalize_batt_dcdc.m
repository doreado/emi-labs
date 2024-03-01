digitizer()

%% 
p = load(['./to_digitalize/bat_dcdc.txt']);
figure
plot(p)

load_curr = format(p(:,1));
eff = format(p(:,2));

disp(load_curr);
disp(eff);