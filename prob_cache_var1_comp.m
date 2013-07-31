function [prob_cache] = prob_cache_var1_comp(dataset)

prob_cache = zeros(size(dataset.feature_set, 2), 7)-1;

display('******Probability of 1 variable precomputing********')
for i = 1:size(dataset.feature_set, 2)
   for j = 1:size(dataset.feature_set, 1)
       if prob_cache(i, dataset.feature_set(j, i)) == -1
           prob_cache(i, dataset.feature_set(j, i)) =  prob_query(i,dataset.feature_set(j, i), dataset.feature_set);
       end
   end
   %display(sprintf('***%f completed***', i/size(dataset.feature_set, 2)));
end


end