action_potentials = load("action_potentials.mat").action_potentials;
firing_samples = load("firing_samples.mat").firing_samples;
% Signal duration is 20 s, and sampling freq. is 10'000Hz
% We will need 200'000 values in our trains
% trains is a matrix where each row is a action train
trains = zeros(8, 2000000);
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
for row = 1:8 % For each train
    for startindex = cell2mat(firing_samples(row)) % for each firing
        for offset = 1:100 % Insert action potentials for that firing
            realtrains(row, startindex + offset) = action_potentials(row, offset);
        end
    end
end

% Plotting the first action train
fullTime = linspace(0, 20, 200000);

tiledlayout(2,1);

axFull1 = nexttile;

plot(axFull1, fullTime, realtrains(1,:))
ylim(axFull1, [-120 120])
ylabel(axFull1, "A.U")
xlabel(axFull1, "Time, (s)")
title(axFull1, "0s to 20s ")

axTenToTenHalf1 = nexttile;
tenToTenHalf = linspace(10, 10.5, 5000);
plot(tenToTenHalf, realtrains(1, 100001:105000))
ylim(axTenToTenHalf1, [-120 120])
ylabel(axTenToTenHalf1, "A.U")
xlabel(axTenToTenHalf1, "Time, (s)")
title(axTenToTenHalf1, "10s to 10.5s")