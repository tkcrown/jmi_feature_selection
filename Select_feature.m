function [sel_indx_set, seq_order, score_set] = Select_feature(feature_set, labels, setting, unsel_indx_set,prob_cache, t, folder_name)
%Return the indice of selected features
sel_indx_set = [];
score_set = [];
 
%I(XiXj;Y)
mutual_info_cache = zeros(size(feature_set, 2), size(feature_set, 2)) - 1;



for i = 1:setting.N_sel_feature
    display(sprintf('For time %d, %dth Feature selection starts',t, i));
    mx = 0;
    mx_idx = 0;
    for idx = unsel_indx_set
        %Compute the score of every unselected feature 
        [mul_score, mutual_info_cache] = jmi_score_cal(feature_set, idx, sel_indx_set, labels, mutual_info_cache, prob_cache); 
        if (mul_score > mx)
            mx_idx = idx;
            mx = mul_score;
        end
    end
    
    
    % Judge if we need more features
    if(i ~= 1)
        if (mx - score_set(end) < setting.threshold)
            display(sprintf('Diff betwwen score %f and %f is too tiny', mx, score_set(end)));
            break;
        end
    end
    
    if mx_idx == 0
        break;
    end
    display(sprintf('%dth feature is seleted, score is %f', mx_idx, mx));
    sel_indx_set = [sel_indx_set, mx_idx];
    unsel_indx_set(unsel_indx_set == mx_idx) = [];
    score_set = [score_set, mx];
    
end

%% Result saved in file
file_name = sprintf('%s/FS_%d',folder_name, t);
fid = fopen(file_name, 'w');
for i = 1:numel(score_set)
    fprintf(fid, '%dth feature %d score %f\n', i, sel_indx_set(i), score_set(i));
end
fclose(fid);

%% End

display(sprintf('***Feature selection terminates, %d features selected for time %d', numel(score_set), t));
seq_order = [sel_indx_set, unsel_indx_set];

end
