function br_image = brightness_reduction(image,reduction)
    hsv_image = rgb2hsv(image);
    %dimensions = size(image);
    %%for i = 1:dimensions(1)
        %%for j = 1:dimensions(2)
            br_image(:, :, 3) = hsv_image(:, :, 3) - (reduction/100);
        %%end
    %%end
    br_image = im2uint8(hsv2rgb(br_image));