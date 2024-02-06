clear;

% Load RGB images and compute power
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
   original_power(count) = power_consumption(original_images{count});
   count = count + 1;
end
original_images = original_images(1:count - 1);
original_power = original_power(1:count - 1);

%% Histogram Equalization
he_images = cell(original_images);
he_power = zeros(size(original_power));
he_power_saved = zeros(size(original_power));
he_eucl = zeros(size(original_power));
he_perc = zeros(size(original_power));
for i=1:length(original_images)
    he_images{i} = histogram_equalization(original_images{i});
    % evaluate metrics
    he_power(i) = power_consumption(he_images{i});
    he_power_saved(i) = power_saved(original_power(i),he_power(i));
    [he_eucl(i),he_perc(i)] = distortion(original_images{i},he_images{i});
end

he_plots(he_power_saved, 'Power Saved', 'Power Saved vs Image');
he_plots(he_perc, 'Distortion', 'Distortion vs Image');
% he_pareto_plots(he_power_saved, he_perc);
he_histograms(he_power_saved, he_perc);

%% Hungry blue
steps = 10;
hb_images = cell([1, 14, steps]);
hb_power = zeros([1, 14, steps]);
hb_power_saved = zeros([1, 14, steps]);
hb_eucl = zeros([1, 14, steps]);
hb_perc = zeros([1, 14, steps]);
for k=1:steps
  for i=1:length(original_images)
      hb_images{i}{k} = hungry_blue(original_images{i}, k*steps);
      hb_power(1, i, k) = power_consumption(hb_images{i}{k});
      hb_power_saved(1, i, k) = power_saved(original_power(i),hb_power(1, i, k));
      [hb_eucl(1, i, k), hb_perc(1, i, k)] = distortion(original_images{i},hb_images{i}{k});
  end
end

% Power vs Images, for each color reduction
hb_plots(14, hb_power_saved, 'Image #', 'Power Savings w.r.t. Original Image -- (%)', 'Power Savings w/ different Color Reduction intensity');

% Dist vs Images, for each color reduction
hb_plots(14, hb_perc, 'Image #', 'Distortion (%)', 'Distortion (%) w/ different Color Reduction intensity');

%% Power vs Dist. Each curve corresponds to a different image 
hb_ratio = zeros(size(hb_power_saved));

pareto_plots(14, hb_power_saved, hb_perc);
%%

function he_plots(y, y_label_str, title_str)
  figure;

  plot(y, '-', 'MarkerSize', 12);
  title(title_str);
  xlabel('Image');
  ylabel(y_label_str);

  grid on;
end

function he_pareto_plots(power_saved, distortion)
  figure;

  % TODO constant
  for i = 1:14
      Y(i) = power_saved(1, i);
      X(i) = distortion(1, i);
  end

  plot(X, Y, '-o', 'MarkerSize', 12);
  title('Power Saved vs Distortion');
  xlabel('Distortion');
  ylabel('Power Saved');

  grid on;
end

function my_plot(idx, distortion, power_consumption)
  figure;
  x=cell2mat(distortion{idx});
  %plot(mat,'-', 'MarkerSize', 12);
  y=cell2mat(power_consumption{idx});
  plot(x, y, '-o', 'MarkerSize', 12);

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
      Y(j) = power_consumption(1, i, j);
      X(j) = dist(1, i, j);
    end

    hold on
    plot(X, Y, '-o', 'DisplayName', "#" + int2str(i*10))
    xticks(1:1:img_num)
    xlim([1 img_num])
    title('Power Saved vs Distortion');
    xlabel('Distortion');
    ylabel('Power Saved');
    lgd = legend;
    lgd.Title.String = "Images #";
    legend(int2str(i));
    hold off
  end
  
  legend("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14");
end

% Power consumption for each reduction level for each image 
% (power_consumptions at same reduction level connected togheter)
function hb_plots(x_point_num, y_vector, x_label_str, y_label_str, title_str)
  Y = [];
  % x_point_num = size(y_vector(1));
  x_axis = linspace(1, x_point_num, x_point_num);
  figure 

  % reduction indeces
  for iterations = 1:10

    % images indeces
    for i = 1:x_point_num
      Y(i) = y_vector(1, i, iterations);
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


% Creates two histograms for history equalization
function he_histograms(collection_power_savings, eucl, num_images)
  x_axis = linspace(1, num_images, num_images);

  figure

  %set(gcf,'position',[10, 10, 1800, 800])
  sgtitle('Histogram Equalization: Energy Savings and Similarity', 'FontWeight','bold', 'FontSize',14);

  subplot(1, 2, 1);
  bar(x_axis, collection_power_savings)
  xticks(1:1:num_images)
  yticks(-160:10:100)
  ylim([-160 100])

  xlabel('Image #');
  ylabel('Energy Savings w.r.t. Original Image -- (%)');

  subplot(1, 2, 2);
  bar(x_axis, eucl)
  yticks(0:5:100)
  ylim([0 100])
  xlabel('Image #');
  ylabel('Euclidean distance (diversity) -- (%)');

  %saveas(gcf, "./Results/HistEqualization/bmp/EnergySavingsPerImage.bmp");
  %saveas(gcf, "./Results/HistEqualization/svg/EnergySavingsPerImage.svg");
end
