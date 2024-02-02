clear;

path = "../../images/sipi/misc/";

files=dir(path);
%% RGB image original
original_images = [];
original_power = [];

%% histogram equalization image RGB
hist_eq_images = [];
hist_eq_power = [];
hist_eq_power_saved = [];
hist_eq_eucl = [];
hist_eq_perc = [];

%% hungry blue image RGB
hungry_blue_images = [];
hungry_blue_power = [];
hungry_blue_saved = [];
hungry_blue_eucl = [];
hungry_blue_perc = [];

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
   %% figure, imshow(original_images{k});
   original_power{count} = power_consumption(original_images{count});
   count = count + 1;
end

%% Histogram equalization
for i=1:length(original_images)
    hist_eq_images{i} = histogram_equalization(original_images{i});
    %% evaluate metrics
    hist_eq_power{i} = power_consumption(hist_eq_images{i});
    hist_eq_power_saved{i} = power_saved(original_images{i},hist_eq_images{i});
    [hist_eq_eucl{i},hist_eq_perc{i}] = distortion(original_images_lab{i},hist_eq_images_lab{i});
end

%% Hungry blue
for i=1:length(original_images)
    hungry_blue_images{i} = hungry_blue(original_images{i});
    hungry_blue_images_power{i} = power_consumption(hungry_blue_images{i});
    hungry_blue__power_saved{i} = power_saved(original_images{i},hungry_blue_images{i});
    [hungry_blue_eucl{i},hist_eq_perc{i}] = distortion(original_images_lab{i},hhungry_blue_images_lab{i});
end






