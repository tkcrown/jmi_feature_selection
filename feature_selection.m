function [sel_feature_set] = feature_selection(dataset, setting, folder_name)
%% Discretize the features
dataset = discretize_feature(dataset, setting.N_disc_feature);

sel_feature_set = cell(1, setting.N_time);


%% Prob_cache_computation
% 1 variable, can be precomputed regardless of t
prob_cache{1} = prob_cache_var1_comp(dataset);

% 2 variables, can be precomputed regardless of t
prob_cache{2} = prob_cache_var2_comp(dataset);

seq_order = [1:size(dataset.feature_set, 2)];
%For every time point, select a set of features
for t = 1:setting.N_time
    
    % Censored data processing
    [dataset, flag] = process_censored_data(dataset, t);
    
    if (flag == true)
        %% Prob_cache_computation
        % 1 variable, can be precomputed regardless of t
        prob_cache{1} = prob_cache_var1_comp(dataset);

        % 2 variables, can be precomputed regardless of t
        prob_cache{2} = prob_cache_var2_comp(dataset);
    end
    prob_cache{3} = prob_cache_var2_cond_comp(dataset, t);
    
    
    display(sprintf('Feature selection for time %d', t));   
    
    [sel_feature_set{t}, seq_order, score_set{t}] = Select_feature(dataset.feature_set, dataset.label(:,t), setting, seq_order, prob_cache, t, folder_name);
end

end




