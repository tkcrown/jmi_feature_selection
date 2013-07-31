function [ds2] = discretize_feature(dataset, n)
%tested
%% Discretize each feature with more than 5 values
for i = 1:size(dataset.feature_set, 2)
    %display(sprintf('feature %d', i));
    num = numel(unique(dataset.feature_set(:, i)));
    if(num > 7)
        dataset.feature_set(:, i) = discretize_one_feature(dataset.feature_set(:, i), n);
    end
    seq = unique(dataset.feature_set(:, i));
    features = dataset.feature_set(:, i);
    for j =1:numel(features)
        features(j) = find(seq == features(j));
    end
    dataset.feature_set(:, i) = features;
end
ds2 = dataset;

end