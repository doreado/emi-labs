%% determines the real current required by an RGB cell to be displayed
function current_cell = current_cell(rgbCell, Vdd)
    p1 = 4.251*10^-05;
    p2 = -3.029*10^-4;
    p3 = 3.024*10^-5;
    current_cell(1) = double(rgbCell(1))*(p1*Vdd/255 + p2/255) + p3;
    current_cell(2) = double(rgbCell(2))*(p1*Vdd/255 + p2/255) + p3;
    current_cell(3) = double(rgbCell(3))*(p1*Vdd/255 + p2/255) + p3;    
end
