%% determines the real current required by a matrix of RGB cells to be displayed
function current_mat = current_mat(A,Vdd)
    for row=1:size(A,1)
	    for col=1:size(A,2)
            current_mat(row,col,:) = current_cell(A(row,col,:),Vdd);
        end
    end
end

