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

steps = Vdd0;
scaled_mat = cell([14, steps]);
power = zeros([14, steps]);
power_saved_mat = zeros([14, steps]);
eucl = zeros([14, steps]);
perc = zeros([14, steps]);
%% dvs
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

%% avg perc
furry = mean(perc, 1);

%% valori dvs image con comparison
%%pt.2
%% brightness o contrast e valori (power saved,consumption,distortion)
%% dvs image e valori
%% comparison tra i valori
