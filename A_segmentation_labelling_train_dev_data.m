clear;clc;close all;

%% for train_data_0
load Data/train_data_0.mat 

train_data = train_data_0;
dt = 0.0005;
T = 2.000;
nt = size(train_data, 1);
nx = size(train_data, 2);


%% pick the event
% d_mask = train_data(1:end, :);
% 
% figure(100);
% imagesc(d_mask, [-1.5 1.5]);colormap(cmap)
% alpha(100);
% n=10;
% while strcmp(input('More?','s'),'y')
%     sig = input('mask=');
%     d_mask(roipoly) = sig;
% end
% 
% figure;imagesc(d_mask, [-1.5 1.5]);colormap(cmap)
% 
%save('Data/mask_train_data_0.mat', 'd_mask', '-v7')

%% labeling data via threshold for synthetic data
load Data/mask_train_data_0.mat
d_label = zeros(size(d_mask));
for ix = 1 : nx
    for it = 1 : nt
        if abs(d_mask(it, ix)) == 0
            d_label(it, ix) = true;
        else
            d_label(it, ix) = false;
        end
    end
end

% figure;imagesc(d_label);

%% create segment: 62 samples ~1*wavelength
d_seg = 62;
N_win = 10;
N_seg_pertr = length(1 : d_seg : nt);
N_seg = N_seg_pertr * nx;

data = zeros(N_seg, d_seg, N_win);
label = zeros(N_seg, 1);
label_toshow = zeros(size(train_data));
tmp = 1 : d_seg : nt;
sp = length(tmp(end) : nt);
for i_seg = 1 : N_seg
    ix = floor((i_seg-1) / N_seg_pertr) + 1;
    i_seg_pertr = mod(i_seg-1, N_seg_pertr)+1;
    it = (i_seg_pertr-1) * d_seg + 1;
    
    if (ix >= N_win/2) && (ix <= nx-N_win/2)
        if i_seg_pertr == N_seg_pertr

            data(i_seg, 1:sp, :) = train_data(it:end, ix-(N_win/2-1):ix+N_win/2);

            if ((sum(d_label(it:end, ix))/length(d_label(it:end, ix)) * 100) < 10)
                label_toshow(it:end, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:end, ix) = 1;
                label(i_seg) = 1;
            end

        else
            data(i_seg, :, :) = train_data(it:it+d_seg-1, ix-(N_win/2-1):ix+N_win/2);
            if ((sum(d_label(it:it+d_seg-1, ix))/length(d_label(it:it+d_seg-1, ix)) * 100) < 10)
                label_toshow(it:it+d_seg-1, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:it+d_seg-1, ix) = 1;
                label(i_seg) = 1;
            end
        end
    elseif (ix < N_win/2)
        if i_seg_pertr == N_seg_pertr

            data(i_seg, 1:sp, end-ix-(N_win/2-1)+1:end) = train_data(it:end, 1:ix+(N_win/2-1));

            if ((sum(d_label(it:end, ix))/length(d_label(it:end, ix)) * 100) < 10)
                label_toshow(it:end, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:end, ix) = 1;
                label(i_seg) = 1;
            end

        else
            data(i_seg, :, end-ix-(N_win/2-1)+1:end) = train_data(it:it+d_seg-1, 1:ix+(N_win/2-1));
            if ((sum(d_label(it:it+d_seg-1, ix))/length(d_label(it:it+d_seg-1, ix)) * 100) < 10)
                label_toshow(it:it+d_seg-1, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:it+d_seg-1, ix) = 1;
                label(i_seg) = 1;
            end
        end       
    elseif (ix > nx-N_win/2)
        if i_seg_pertr == N_seg_pertr

            data(i_seg, 1:sp, 1:nx-ix+N_win/2+1) = train_data(it:end, ix-N_win/2:nx);

            if ((sum(d_label(it:end, ix))/length(d_label(it:end, ix)) * 100) < 10)
                label_toshow(it:end, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:end, ix) = 1;
                label(i_seg) = 1;
            end

        else
            data(i_seg, :, 1:nx-ix+N_win/2+1) = train_data(it:it+d_seg-1, ix-N_win/2:nx);
            if ((sum(d_label(it:it+d_seg-1, ix))/length(d_label(it:it+d_seg-1, ix)) * 100) < 10)
                label_toshow(it:it+d_seg-1, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:it+d_seg-1, ix) = 1;
                label(i_seg) = 1;
            end
        end 
    end
end

figure;imagesc([train_data .* label_toshow train_data], [-1.5 1.5])
title('train data 0 (left-labelled, right-original)')
print -djpg Fig/train_data_0.jpg

save('Data/seg_train_data_0.mat', 'data', '-v7')
save('Data/label_train_data_0.mat', 'label', '-v7')

fprintf('----------------------------------------\n');
disp('train and development data 0 are generated');
fprintf('----------------------------------------\n');

%% for train_data_1
load Data/train_data_1.mat 

train_data = train_data_1;
dt = 0.0005;
T = 2.000;
nt = size(train_data, 1);
nx = size(train_data, 2);


%% pick the event
% d_mask = train_data(1:end, :);
% 
% figure(100);
% imagesc(d_mask, [-1.5 1.5]);colormap(cmap)
% alpha(100);
% n=10;
% while strcmp(input('More?','s'),'y')
%     sig = input('mask=');
%     d_mask(roipoly) = sig;
% end
% 
% figure;imagesc(d_mask, [-1.5 1.5]);colormap(cmap)
% 
%save('Data/mask_train_data_1.mat', 'd_mask', '-v7')

%% labeling data via threshold for synthetic data
load Data/mask_train_data_1.mat
d_label = zeros(size(d_mask));
for ix = 1 : nx
    for it = 1 : nt
        if abs(d_mask(it, ix)) == 0
            d_label(it, ix) = true;
        else
            d_label(it, ix) = false;
        end
    end
end

% figure;imagesc(d_label);

%% create segment: 62 samples ~1*wavelength
d_seg = 62;
N_win = 10;
N_seg_pertr = length(1 : d_seg : nt);
N_seg = N_seg_pertr * nx;

data = zeros(N_seg, d_seg, N_win);
label = zeros(N_seg, 1);
label_toshow = zeros(size(train_data));
tmp = 1 : d_seg : nt;
sp = length(tmp(end) : nt);
for i_seg = 1 : N_seg
    ix = floor((i_seg-1) / N_seg_pertr) + 1;
    i_seg_pertr = mod(i_seg-1, N_seg_pertr)+1;
    it = (i_seg_pertr-1) * d_seg + 1;
    
    if (ix >= N_win/2) && (ix <= nx-N_win/2)
        if i_seg_pertr == N_seg_pertr

            data(i_seg, 1:sp, :) = train_data(it:end, ix-(N_win/2-1):ix+N_win/2);

            if ((sum(d_label(it:end, ix))/length(d_label(it:end, ix)) * 100) < 10)
                label_toshow(it:end, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:end, ix) = 1;
                label(i_seg) = 1;
            end

        else
            data(i_seg, :, :) = train_data(it:it+d_seg-1, ix-(N_win/2-1):ix+N_win/2);
            if ((sum(d_label(it:it+d_seg-1, ix))/length(d_label(it:it+d_seg-1, ix)) * 100) < 10)
                label_toshow(it:it+d_seg-1, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:it+d_seg-1, ix) = 1;
                label(i_seg) = 1;
            end
        end
    elseif (ix < N_win/2)
        if i_seg_pertr == N_seg_pertr

            data(i_seg, 1:sp, end-ix-(N_win/2-1)+1:end) = train_data(it:end, 1:ix+(N_win/2-1));

            if ((sum(d_label(it:end, ix))/length(d_label(it:end, ix)) * 100) < 10)
                label_toshow(it:end, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:end, ix) = 1;
                label(i_seg) = 1;
            end

        else
            data(i_seg, :, end-ix-(N_win/2-1)+1:end) = train_data(it:it+d_seg-1, 1:ix+(N_win/2-1));
            if ((sum(d_label(it:it+d_seg-1, ix))/length(d_label(it:it+d_seg-1, ix)) * 100) < 10)
                label_toshow(it:it+d_seg-1, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:it+d_seg-1, ix) = 1;
                label(i_seg) = 1;
            end
        end       
    elseif (ix > nx-N_win/2)
        if i_seg_pertr == N_seg_pertr

            data(i_seg, 1:sp, 1:nx-ix+N_win/2+1) = train_data(it:end, ix-N_win/2:nx);

            if ((sum(d_label(it:end, ix))/length(d_label(it:end, ix)) * 100) < 10)
                label_toshow(it:end, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:end, ix) = 1;
                label(i_seg) = 1;
            end

        else
            data(i_seg, :, 1:nx-ix+N_win/2+1) = train_data(it:it+d_seg-1, ix-N_win/2:nx);
            if ((sum(d_label(it:it+d_seg-1, ix))/length(d_label(it:it+d_seg-1, ix)) * 100) < 10)
                label_toshow(it:it+d_seg-1, ix) = 0;
                label(i_seg) = 0;
            else
                label_toshow(it:it+d_seg-1, ix) = 1;
                label(i_seg) = 1;
            end
        end 
    end
end

figure;imagesc([train_data .* label_toshow train_data], [-1.5 1.5])
title('train data 1 (left-labelled, right-original)')
print -djpg Fig/train_data_1.jpg

save('Data/seg_train_data_1.mat', 'data', '-v7')
save('Data/label_train_data_1.mat', 'label', '-v7')

fprintf('----------------------------------------\n');
disp('train and development data 1 are generated');
fprintf('----------------------------------------\n');


%% Devide the generated data into train and dev data 
load Data/seg_train_data_0.mat
load Data/label_train_data_0.mat

data_0 = data;
label_0 = label;

load Data/seg_train_data_1.mat
load Data/label_train_data_1.mat

data_orig = [data; data_0];
label_orig = [label; label_0];

N = size(label_orig, 1);

data = zeros(size(data_orig));
label = zeros(size(label_orig));
[data, I] = shuffle(data_orig, 1);
for i = 1 : N
    label(i) = label_orig(I(i));
end


X_train = data(1:N*0.8, :, :);
X_dev = data(N*0.8+1:end, :, :);

Y_train = label(1:N*0.8, :);
Y_dev = label(N*0.8+1:end, :);

save('Data/X_train.mat', 'X_train', '-v7')
save('Data/X_dev.mat', 'X_dev', '-v7')
save('Data/Y_train.mat', 'Y_train', '-v7')
save('Data/Y_dev.mat', 'Y_dev', '-v7')


fprintf('----------------------------------------\n');
disp('train (80%) and development (20%) are ready for training');
fprintf('----------------------------------------\n');

waitfor(gcf)

