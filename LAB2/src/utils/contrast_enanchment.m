function ce_image = contrast_enanchment(image, b)
    hsv_image = rgb2hsv(image);
    hsv_image(:, :, 3) = hsv_image(:, :, 3) * (b / 100);
    ce_image = im2uint8(hsv2rgb(hsv_image));
    