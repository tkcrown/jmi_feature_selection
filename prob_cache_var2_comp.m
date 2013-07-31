function [prob_cache] = prob_cache_var2_comp(dataset)

prob_cache = zeros(size(dataset.feature_set, 2), size(dataset.feature_set, 2), 7, 7)-1;
display('******Probability of 2 variable precomputing********')
for i = 1:size(dataset.feature_set, 2)
    for j = i+1:size(dataset.feature_set, 2)
        for k = 1:size(dataset.feature_set, 1)
            if prob_cache(i,j, dataset.feature_set(k,i), dataset.feature_set(k, j)) == -1
                prob_cache(i,j, dataset.feature_set(k,i), dataset.feature_set(k, j)) =  prob_query([i, j], [dataset.feature_set(k, i),dataset.feature_set(k, j)], dataset.feature_set);
                prob_cache(j,i, dataset.feature_set(k,j), dataset.feature_set(k, i)) = prob_cache(i,j, dataset.feature_set(k,i), dataset.feature_set(k, j));
            end
        end
    end
    %display(sprintf('***%f completed***', i/size(dataset.feature_set, 2)));
end

end