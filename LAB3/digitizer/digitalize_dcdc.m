digitizer();
%% 
p = load(['./to_digitalize/pv_dcdc.txt']);
figure

voltages = format(p(:,1));
eff = format(p(:,2));

disp(voltages);
disp(eff);

function formatted = format(array)
formatted = '';
for i = 1:length(array)
    % Append the current element to the formatted string
    formatted = [formatted, num2str(array(i))];
    
    % Add a comma and space if it's not the last element
    if i < length(array)
        formatted = [formatted, ', '];
    end
end
end
