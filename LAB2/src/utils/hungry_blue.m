function hb_image = hungry_blue(image,reduction_perc)
    hb_image = image;
    dimensions = size(image);
    for i = 1:dimensions(1)
        for j = 1:dimensions(2)
            hb_image(i, j, 3) = image(i, j, 3) - (reduction_perc/255)*100;
        end
    end
