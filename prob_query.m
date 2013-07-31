function [ prob ] = prob_query( indx_set,value_set, data_set)
%Tested
%PROB_QUERY Summary of this function goes here
%   Detailed explanation goes here
n = sum(sum(data_set(:,indx_set) == repmat(value_set, size(data_set, 1), 1), 2) == numel(indx_set));

prob = n/size(data_set, 1);

end

