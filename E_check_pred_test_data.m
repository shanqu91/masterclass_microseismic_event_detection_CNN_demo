clear;clc;close all;

%% visualize the predicted test_data_0
load Data/test_data_0.mat 

test_data = test_data_0;
dt = 0.0005;
T = 2.000;
nt = size(test_data, 1);
nx = size(test_data, 2);

%%
load Data/Y_test_0.mat
label_pred_tmp = round(Y_test_0);
label_pred = label_pred_tmp(:, 1);

d_seg = 62;
N_seg_pertr = length(1 : d_seg : nt);
N_seg = N_seg_pertr * nx;

% label = zeros(N_seg, 1);
label_toshow = zeros(size(test_data));
tmp = 1 : d_seg : nt;
sp = length(tmp(end) : nt);
for i_seg = 1 : N_seg
    ix = floor((i_seg-1) / N_seg_pertr) + 1;
    i_seg_pertr = mod(i_seg-1, N_seg_pertr)+1;
    it = (i_seg_pertr-1) * d_seg + 1;
    
    if i_seg_pertr == N_seg_pertr
        if label_pred(i_seg)
            label_toshow(it:end, ix) = 0;
        else
            label_toshow(it:end, ix) = 1;
        end
    else
        if label_pred(i_seg)
            label_toshow(it:it+d_seg-1, ix) = 0;
        else
            label_toshow(it:it+d_seg-1, ix) = 1;
        end
    end
end

figure;imagesc([test_data .*label_toshow test_data], [-1.5 1.5])
title('CNN: test data 0 (left-predicted label, right-original)')
print -djpg Fig/predicted_test_data_0.jpg

load Data/SVM_label_test_data_0.mat
figure;imagesc([test_data .*label_toshow test_data], [-1.5 1.5])
title('preloaded SVM: test data 0 (left-predicted label, right-original)')
print -djpg Fig/SVM_predicted_test_data_0.jpg



%% visualize the predicted test_data_1
load Data/test_data_1.mat 

test_data = test_data_1;
dt = 0.0005;
T = 2.000;
nt = size(test_data, 1);
nx = size(test_data, 2);

% figure;imagesc(test_data, [-1.5 1.5])


%%
load Data/Y_test_1.mat
label_pred_tmp = round(Y_test_1);
label_pred = label_pred_tmp(:, 1);

d_seg = 62;
N_seg_pertr = length(1 : d_seg : nt);
N_seg = N_seg_pertr * nx;

% label = zeros(N_seg, 1);
label_toshow = zeros(size(test_data));
tmp = 1 : d_seg : nt;
sp = length(tmp(end) : nt);
for i_seg = 1 : N_seg
    ix = floor((i_seg-1) / N_seg_pertr) + 1;
    i_seg_pertr = mod(i_seg-1, N_seg_pertr)+1;
    it = (i_seg_pertr-1) * d_seg + 1;
    
    if i_seg_pertr == N_seg_pertr
        if label_pred(i_seg)
            label_toshow(it:end, ix) = 0;
        else
            label_toshow(it:end, ix) = 1;
        end
        
    else
        if label_pred(i_seg)
            label_toshow(it:it+d_seg-1, ix) = 0;
        else
            label_toshow(it:it+d_seg-1, ix) = 1;
        end
    end
end

figure;imagesc([test_data .*label_toshow test_data], [-1.5 1.5])
title('CNN: test data 1 (left-predicted label, right-original)')
print -djpg Fig/predicted_test_data_1.jpg

load Data/SVM_label_test_data_1.mat
figure;imagesc([test_data .*label_toshow test_data], [-1.5 1.5])
title('preloaded SVM: test data 1 (left-predicted label, right-original)')
print -djpg Fig/SVM_predicted_test_data_1.jpg

waitfor(gcf)
