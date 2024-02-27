% Increase the pixel values of an RGB image by a certain percentage b
function br_scaling = brightness_increase(image, b)
    hsv_image = rgb2hsv(image);
    br_image(:, :, 3) = hsv_image(:, :, 3) + (b / 100);
    br_scaling = im2uint8(hsv2rgb(br_image));
    