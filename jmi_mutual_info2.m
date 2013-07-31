function [ re ] = jmi_mutual_info2( idx1, idx2, data_set)
%Tested
%MUTUAL_INFO_COMP Summary of this function goes here
%   Detailed explanation goes here

re = 0;
prob1_cache = zeros(size(data_set, 2)-1, 7, 2)-1;
prob2_cache = zeros(size(data_set, 2)-1, 7)-1;
prob3_cache = zeros(1,2)-1;
for i = data_set'
    tuple = i';
    if prob1_cache(idx1, tuple(idx1), tuple(idx2)) == -1
        prob1_cache(idx1, tuple(idx1), tuple(idx2))  = prob_query( [idx1, idx2], tuple([idx1, idx2]), data_set);
    end
    prob1 = prob1_cache(idx1, tuple(idx1), tuple(idx2));
    
    if prob2_cache( idx1, tuple(idx1)) == -1
        prob2_cache( idx1, tuple(idx1))  = prob_query( idx1, tuple(idx1), data_set);
    end    
    prob2 = prob2_cache( idx1, tuple(idx1));
    
    if prob3_cache(tuple(idx2)) == -1
        prob3_cache(tuple(idx2))  = prob_query( idx2, tuple(idx2), data_set);
    end
    prob3 = prob3_cache(tuple(idx2));
    
    re = re + log(prob1/(prob2 * prob3));
end
re = re/size(data_set, 1);
end

