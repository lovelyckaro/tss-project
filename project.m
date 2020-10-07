action_potentials = load("action_potentials.mat").action_potentials;
firing_samples = load("firing_samples.mat").firing_samples;
% Signal duration is 20 s, and sampling freq. is 10'000Hz
% We will need 200'000 values in our trains
% trains is a matrix where each row is a action train
trains = zeros(8, 200000);
for row = 1:8
    for column = cell2mat(firing_samples(row))
        trains(row, column) = 1;
    end
end

% find finds indices of non-zero elements
% run it on first train to find where we have placed our 1s
% make sure that it is equal to the indices in firing_samples first row
if not(isequal(transpose(find(trains(1,:))), cell2mat(firing_samples(1))))
    disp("indices not equal");
end

realtrains = zeros(8, 200000);

% Does this work?
for i = 1:8
  realtrains(i,:) = conv(trains(i,:), action_potentials(i,:))
end

% Plotting the first action train
fullTime = linspace(0, 20, 200000);

tiledlayout(3,2);

axFull1 = nexttile;

plot(axFull1, fullTime, realtrains(1,:))
ylim(axFull1, [-200 200])
ylabel(axFull1, "A.U")
xlabel(axFull1, "Time, (s)")
title(axFull1, "Action train 1: 0s to 20s ")

axTenToTenHalf1 = nexttile;
tenToTenHalf = linspace(10, 10.5, 5000);
plot(tenToTenHalf, realtrains(1, 100001:105000))
ylim(axTenToTenHalf1, [-200 200])
ylabel(axTenToTenHalf1, "A.U")
xlabel(axTenToTenHalf1, "Time, (s)")
title(axTenToTenHalf1, "Action train 1: 10s to 10.5s")

emg = zeros(1, 200000);

for row = 1:8
    for column = 1:200000
        emg(column) = emg(column) +  realtrains(row, column);
    end
end

axEmg = nexttile;
plot(fullTime, emg(:))
ylim(axEmg, [-200 200])
ylabel(axEmg, "A.U")
xlabel(axEmg, "Time, (s)")
title(axEmg, "EMG: 0s to 20s")

axEmg2 = nexttile;
plot(tenToTenHalf, emg(1, 100001:105000))
ylim(axEmg2, [-200 200])
ylabel(axEmg2, "A.U")
xlabel(axEmg2, "Time, (s)")
title(axEmg2, "EMG: 10s to 10.5s")


% QUESTION 2


% Time to filter

filtered = zeros(8, 200000);
filteredAx = nexttile;
hold on

for row = 1:8
    filtered(row,:) = conv(trains(row,:), hann(10000), 'same');
    plot(filteredAx, fullTime, filtered(row, :))
end
ylabel(filteredAx, "A.U")
xlabel(filteredAx, "Time, (s)")
title(filteredAx, "Binary vectors, filtered using Hanning window")


wvtool(filtered(1,:), filtered(2,:), filtered(3,:), filtered(4,:), filtered(5,:), filtered(6,:), filtered(7,:), filtered(8,:))

hold off
