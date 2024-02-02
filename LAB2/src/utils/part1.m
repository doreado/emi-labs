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
    hist_eq_power_saved{i} = power_saved(original_power{i},hist_eq_power{i});
    [hist_eq_eucl{i},hist_eq_perc{i}] = distortion(original_images{i},hist_eq_images{i});
end

%% Hungry blue
for k=1:10
  for i=1:length(original_images)
      hungry_blue_images{i}{k} = hungry_blue(original_images{i}, k*10);
      hungry_blue_images_power{i}{k} = power_consumption(hungry_blue_images{i}{k});
      hungry_blue_power_saved{i}{k} = power_saved(original_power{i},hungry_blue_images_power{i}{k});
      [hungry_blue_eucl{i}{k},hungry_blue_perc{i}{k}] = distortion(original_images{i},hungry_blue_images{i}{k});
  end
end

% Energy vs Images, for each color reduction
hb_plots(14, hungry_blue_power_saved, 'Image #', 'Energy Savings w.r.t. Original Image -- (%)', 'Energy Savings w/ different Color Reduction intensity');

% Dist vs Images, for each color reduction
hb_plots(14, hungry_blue_perc, 'Image #', 'Distortion (%)', 'Distortion (%) w/ different Color Reduction intensity');

% 
pareto_plots(14, hist_eq_power, hist_eq_perc);

function my_plot(idx, distortion, power_consumption)
  figure;
  x=cell2mat(distortion{idx});
  %plot(mat,'-', 'MarkerSize', 12);
  y=cell2mat(power_consumption{idx});
  plot(x, y, '-', 'MarkerSize', 12);

  title(idx);
  xlabel('Distortion');
  ylabel('Power saved');

  grid on;
end

function pareto_plots(img_num, power_consumption, dist)
  % x_axis = linspace(1, img_num, img_num);
  figure 

  for i = 1:img_num
    for j = 1:10
      Y(i) = power_consumption{i}{j};
      X(i) = dist{i}{j};
    end

    hold on
    plot(X, Y, '-o', 'DisplayName', int2str(i*10) + "%")
    xticks(1:1:img_num)
    xlim([1 img_num])
    title('Power Consumption vs Distortion');
    xlabel('Distortion');
    ylabel('Power Consumption');
    lgd = legend;
    lgd.Title.String = "Images #";
    legend(int2str(i));
    hold off
  end
end

function hb_plots(x_point_num, y_vector, x_label_str, y_label_str, title_str)
  Y = [];
  % x_point_num = size(y_vector(1));
  x_axis = linspace(1, x_point_num, x_point_num);
  figure 

  % reduction indeces
  for iterations = 1:10

    % images indeces
    for i = 1:x_point_num
      Y(i) = y_vector{i}{iterations};
    end

    hold on
    plot(x_axis, Y, '-o', 'DisplayName', int2str(iterations*10) + "%")
    xticks(1:1:x_point_num)
    xlim([1 x_point_num])
    title(title_str);
    xlabel(x_label_str);
    ylabel(y_label_str);
    lgd = legend;
    lgd.Title.String = "Color Reduction %";
    % legend(int2str(iterations*10) + "%")
    hold off

  end

  legend("10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%");

  % saveas(gcf, "./Results/ColorReduction/bmp/EnergySavingsPerImage.bmp");
  % saveas(gcf, "./Results/ColorReduction/svg/EnergySavingsPerImage.svg");
end

% per ogni immagine 
% power_saved vs 
