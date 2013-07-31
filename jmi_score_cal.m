function [mul_score, mutual_info_cache] = jmi_score_cal(data_set, idx, sel_indx_set, labels, mutual_info_cache, prob_cache)

%% General_Algorithm_jmi_1
% I_1 = mutual_info_comp( idx, size(data_set, 2) + 1, [data_set,labels]);
% I_2 = 0;
% 
% for j = sel_indx_set
%     %Debug
%     %idx
%     %j
%     %Debug Done
%     
%     I_2 = I_2 + mutual_info_comp( idx, j, data_set);
%     I_2 = I_2 - cond_mutual_info_comp( idx, j, size(data_set, 2) + 1, [data_set,labels]);
% end
% 
% if numel(sel_indx_set) > 0
%     mul_score = I_1 - I_2/numel(sel_indx_set);
% else
%     mul_score = I_1;
% 

% I_3 = 0;
% data_set_with_labels = [data_set,labels];
% 
% %% General_Algorithm_jmi_2
% if numel(sel_indx_set) > 0
%     for j = sel_indx_set
%         I_3 = I_3 + mutual_info_comp([idx, j],size(data_set_with_labels, 2), data_set_with_labels);
%     end
% else
%     I_3 = mutual_info_comp( idx, size(data_set_with_labels, 2), data_set_with_labels);
%     %I_3 = I_1;
% end
%mul_score = I_3;

%% Insane_check
% if abs(mul_score - I_3) > 0.001
%     display('Warning! Difference is too big');
%     st = sprintf('%lf %lf', mul_score, I_3);
%     display(st);
% end


I_4 = 0;
data_set_with_labels = [data_set,labels];
%% Speedy_jmi

if numel(sel_indx_set) > 0
    for j = sel_indx_set
        if (mutual_info_cache(idx, j) == -1)
            mutual_info_cache(idx, j) = jmi_mutual_info([idx, j],size(data_set_with_labels, 2), data_set_with_labels, prob_cache);
            mutual_info_cache(j, idx) = mutual_info_cache(idx, j);
        end
        I_4 = I_4 + mutual_info_cache(idx, j);
    end
else
    I_4 = jmi_mutual_info2( idx, size(data_set_with_labels, 2), data_set_with_labels);
end
mul_score = I_4;


% Insane_check
% if abs(I_4 - I_3) > 0.001
%     display('Warning! Difference is too big');
%     st = sprintf('%lf %lf', I_4, I_3);
%     display(st);
% end




end