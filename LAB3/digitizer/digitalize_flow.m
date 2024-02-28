digitizer()
%% Plots are written: extract the MPPs
    
blue_mpp = mpp('blue');
orange_mpp = mpp('orange');
green_mpp = mpp('green');
purple_mpp = mpp('purple');

currents = [blue_mpp(1), orange_mpp(1), green_mpp(1), purple_mpp(1)]
voltages = [blue_mpp(2), orange_mpp(2), green_mpp(2), purple_mpp(2)]

function MPP = mpp(color)
    p = load(['./to_digitalize/' color '.txt']);

    power = p(:, 1) .* p(:, 2);

    % Plot the data
    figure
    plot(p(:, 1), power);
    xlabel('Voltage');
    ylabel('Power')

    % Find the index of the maximum power
    [~, max_index] = max(power);

    % Set variables output
    Impp = p(max_index, 2);
    Vmpp = p(max_index, 1);
    MPP = [Impp, Vmpp];
end 