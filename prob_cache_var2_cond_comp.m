function [prob_cache] = prob_cache_var2_cond_comp(dataset, t) 
    prob_cache = zeros(size(dataset.feature_set, 2), size(dataset.feature_set, 2), 7, 7, 2)-1;
    % 3 variables with the last being label, cannot be precomputed regardless of t
    display('******Probability of 3 variables precomputing********')
    for i = 1:size(dataset.feature_set, 2)
        for j = i+1:size(dataset.feature_set, 2)
            for m = 1:size(dataset.feature_set, 1)
                if prob_cache(i,j, dataset.feature_set(m,i), dataset.feature_set(m, j), dataset.label(m,t)) == -1
                    prob_cache(i,j, dataset.feature_set(m,i), dataset.feature_set(m,j), dataset.label(m,t)) = prob_query([i, j, size(dataset.feature_set,2)+1], [dataset.feature_set(m, i),dataset.feature_set(m, j), dataset.label(m,t)], [dataset.feature_set, dataset.label(:,t)]);
                    prob_cache(j,i, dataset.feature_set(m,j), dataset.feature_set(m,i), dataset.label(m,t)) = prob_cache(i,j, dataset.feature_set(m,i), dataset.feature_set(m, j), dataset.label(m,t)); 
                end
            end
        end
        if (mod(i,3) == 0)
            display(sprintf('***%f completed***', i/size(dataset.feature_set, 2)));
        end
    end
    
end