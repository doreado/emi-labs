function power = power_consumption(image) 

    w0 = 1.48169521e-6;
    wr = 2.13636845e-7;
    wg = 1.77746705e-7;
    wb = 2.14348309e-7;
    gamma = 0.7755;
    
    p_pixel = [];
    power = 0;
    dimensions = size(image);
    pixel_power = 0;
    for i = 1:dimensions(1)
       for j = 1:dimensions(2)
            %%p_pixel(i,j) = wr*(image(i,j,1)^gamma) + wg*(image(i,j,2)^gamma) + wb*(image(i,j,3)^gamma);
            p_pixel(i,j) = wr*(double(image(i,j,1))^gamma) + wg*(double(image(i,j,2))^gamma) + wb*(double(image(i,j,3))^gamma);
            pixel_power = pixel_power + p_pixel(i, j);
        end
    end
    
   power = w0 + pixel_power;