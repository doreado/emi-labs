digitizer();

%%
green = load(['./to_digitalize/v_soc_green.txt']);
red = load(['./to_digitalize/v_soc_red.txt']);

greenCurrent = 3200;
redCurrent = 3200 / 2;

soc = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
figure;
plot(green);
newYGreen = interp1(green(:,1), green(:,2), soc);
newYRed = interp1(red(:,1), red(:,2), soc);

for i = 1:size(newYRed, 2)
    R(i) = (newYRed(i) - newYGreen(i)) / (greenCurrent - redCurrent);
    VOC(i) = newYRed(i) + R(i) * redCurrent;
end