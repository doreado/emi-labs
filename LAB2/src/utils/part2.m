format long

SATURATED = 1;
Vdd0 = 15; % original Vdd is 15
Vdd = 11;

%% valori original image
path = "../../images/sipi/misc/";
files=dir(path);
original_images = cell(1, length(files));
original_power = zeros(1, length(files));

count = 1;
for k=1:length(files)
   fileNames = files(k).name;
   if strcmp(fileNames,".") || strcmp(fileNames,"..") 
        continue;
   end
   tmp = imread(path+fileNames);
   [rows, cols, chans] = size(tmp);
   if chans < 3
       continue;
   end
 
   original_images{count} = tmp;
   original_power(count) = power_panel(original_images{count}, Vdd0);
   count = count + 1;
end
original_images = original_images(1:count - 1);
original_power = original_power(1:count - 1);

%% dvs
steps = Vdd0;
scaled_mat = cell([14, steps]);
power = zeros([14, steps]);
power_saved_mat = zeros([14, steps]);
eucl = zeros([14, steps]);
perc = zeros([14, steps]);

for k=1:Vdd0
  for i=1:length(original_images)
    scaled_vdd = Vdd0 - k;
    I_cell = current_mat(original_images{i}, scaled_vdd);
    scaled_mat{i}{k} = uint8(displayed_image(I_cell, scaled_vdd, 1));

    power(i, k) = power_panel(scaled_mat{i}{k}, scaled_vdd);
    power_saved_mat(i, k) = power_saved(original_power(i), power(i, k));
    [eucl(i, k), perc(i, k)] = distortion(original_images{i},scaled_mat{i}{k});
  end
end

%% valori dvs image con comparison

%% brightness increase and DVS
scaled_vdd = 14; % constraint on distortion

steps = 4; % 0 (original ones) 25 50 75 100
bi_images = cell([14, steps]);
bi_power = zeros([14, steps]);
bi_power_saved = zeros([14, steps]);
bi_eucl = zeros([14, steps]);
bi_perc = zeros([14, steps]);

for k=1:steps
  for i=1:length(original_images)
    bi_image = brightness_increase(original_images{i}, k*25);

    % Vdd scaling
    I_cell = current_mat(bi_image, scaled_vdd);
    bi_images{i}{k} = uint8(displayed_image(I_cell, scaled_vdd, 1));

    bi_power(i, k) = power_panel(bi_images{i}{k}, scaled_vdd);
    bi_power_saved(i, k) = power_saved(original_power(i), bi_power(i, k));
    [bi_eucl(i, k), bi_perc(i, k)] = distortion(original_images{i}, bi_images{i}{k});
  end 
end
%% TEST
subplot(1, 3, 1);
o = brightness_increase(original_images{1}, 1*25);
imshow(o);
subplot(1, 3, 2);
imshow(scaled_mat{1}{1});
subplot(1, 3, 3);
imshow(bi_images{1}{1});
% contrast  
%% dvs image e valori
%% comparison tra i valori
