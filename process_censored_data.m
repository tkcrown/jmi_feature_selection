function [dataset, flag] = process_censored_data(dataset, t)

censor_list = ((dataset.label(:,t) == 2).*(dataset.censored == 1)) == 1;

dataset.feature_set(censor_list, :) = [];
dataset.label(censor_list, :) = [];
dataset.censored(censor_list,:) = [];

if (sum(censor_list) == 0)
    flag = false;
else
    flag = true;
end

display(sprintf('###%d data samples are censored out at time %d, %d samples left###', numel(find(censor_list==1)), t, size(dataset.feature_set, 1)));

end