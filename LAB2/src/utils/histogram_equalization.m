function h_eq_image = histogram_equalization(image)

    HSV_image = rgb2hsv(image);
    temp = HSV_image(:, :, 3);
    value = histeq(temp);
    HSV_image_mod = HSV_image;
    HSV_image_mod(:, :, 3) = value;
    h_eq_image = hsv2rgb(HSV_image_mod);
