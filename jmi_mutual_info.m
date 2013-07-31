function [ re ] = jmi_mutual_info( idx1, idx2, feature_set, prob_cache)
%Tested
%MUTUAL_INFO_COMP Summary of this function goes here
%   Detailed explanation goes here
%tic;
re = 0;
tuple_set = feature_set(:,[idx1, idx2])';

prob3 = zeros(1, 2);
prob3(1) = prob_query(idx2, 1, feature_set);
prob3(2) = prob_query(idx2, 2, feature_set);

for tuple = tuple_set
    
    prob1 = prob_cache{3}(idx1(1),idx1(2),tuple(1),tuple(2),tuple(3));
    
    prob2 = prob_cache{2}(idx1(1),idx1(2),tuple(1),tuple(2));
    
    if(prob1 == -1 || prob2 == -1)
        display('Warning!!!! Prob not precomputed!!!');
        while(1)
        end
    end
    
    re = re + log(prob1/(prob2 * prob3(tuple(3))));
end
re = re/size(feature_set, 1);
%toc;
end

