%% determines the real power required by a matrix of RGB cells to be displayed, starting from a CURRENT MATRIX and the Vdd
function power_panel = power_panel(I,Vdd)
    power_panel = 0.0;
    for row=1:size(I,1)
	    for col=1:size(I,2)
            for channel=1:3 %loop around rgb channels
                power_panel = power_panel + double(I(row,col,channel));
            end
        end
    end
    power_panel = Vdd*power_panel;

