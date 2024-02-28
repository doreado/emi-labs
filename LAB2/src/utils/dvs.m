function scaled_image = dvs(image, new_vdd)
SATURATED = 1;
I_cell = current_mat(image, new_vdd);
scaled_image = uint8(displayed_image(I_cell, new_vdd, SATURATED));
