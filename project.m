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

