clear;clc;close all;

%% generate test_data_0
load Data/test_data_0.mat 

test_data = test_data_0;
dt = 0.0005;
T = 2.000;
nt = size(test_data, 1);
nx = size(test_data, 2);

figure;imagesc(test_data, [-1.5 1.5]);
title('test data 0')
print -djpg Fig/test_data_0.jpg

%% create segment: 62 samples ~1*wavelength
d_seg = 62;
N_win = 10;
N_seg_pertr = length(1 : d_seg : nt);
N_seg = N_seg_pertr * nx;

data = zeros(N_seg, d_seg, N_win);
label = zeros(N_seg, 1);
label_toshow = zeros(N_seg_pertr, nx);
tmp = 1 : d_seg : nt;
sp = length(tmp(end) : nt);
for i_seg = 1 : N_seg
    ix = floor((i_seg-1) / N_seg_pertr) + 1;
    i_seg_pertr = mod(i_seg-1, N_seg_pertr)+1;
    it = (i_seg_pertr-1) * d_seg + 1;
    
    if (ix >= N_win/2) && (ix <= nx-N_win/2)
        if i_seg_pertr == N_seg_pertr
            data(i_seg, 1:sp, :) = test_data(it:end, ix-(N_win/2-1):ix+N_win/2);
        else
            data(i_seg, :, :) = test_data(it:it+d_seg-1, ix-(N_win/2-1):ix+N_win/2);
        end
    elseif (ix < N_win/2)
        if i_seg_pertr == N_seg_pertr
            data(i_seg, 1:sp, end-ix-(N_win/2-1)+1:end) = test_data(it:end, 1:ix+(N_win/2-1));
        else
            data(i_seg, :, end-ix-(N_win/2-1)+1:end) = test_data(it:it+d_seg-1, 1:ix+(N_win/2-1));
        end       
    elseif (ix > nx-N_win/2)
        if i_seg_pertr == N_seg_pertr
            data(i_seg, 1:sp, 1:nx-ix+N_win/2+1) = test_data(it:end, ix-N_win/2:nx);
        else
            data(i_seg, :, 1:nx-ix+N_win/2+1) = test_data(it:it+d_seg-1, ix-N_win/2:nx);
        end 
    end
end

X_test_0 = data;
save('Data/X_test_0.mat', 'X_test_0', '-v7')

fprintf('----------------------------------------\n');
disp('test data 0 are generated');
fprintf('----------------------------------------\n');

%% generate test_data_1
load Data/test_data_1.mat 

test_data = test_data_1;
dt = 0.0005;
T = 2.000;
nt = size(test_data, 1);
nx = size(test_data, 2);

figure;imagesc(test_data, [-1.5 1.5]);
title('test data 1')
print -djpg Fig/test_data_1.jpg

%% create segment: 62 samples ~1*wavelength

d_seg = 62;
N_win = 10;
N_seg_pertr = length(1 : d_seg : nt);
N_seg = N_seg_pertr * nx;

data = zeros(N_seg, d_seg, N_win);
label = zeros(N_seg, 1);
label_toshow = zeros(N_seg_pertr, nx);
tmp = 1 : d_seg : nt;
sp = length(tmp(end) : nt);
for i_seg = 1 : N_seg
    ix = floor((i_seg-1) / N_seg_pertr) + 1;
    i_seg_pertr = mod(i_seg-1, N_seg_pertr)+1;
    it = (i_seg_pertr-1) * d_seg + 1;
    
    if (ix >= N_win/2) && (ix <= nx-N_win/2)
        if i_seg_pertr == N_seg_pertr
            data(i_seg, 1:sp, :) = test_data(it:end, ix-(N_win/2-1):ix+N_win/2);
        else
            data(i_seg, :, :) = test_data(it:it+d_seg-1, ix-(N_win/2-1):ix+N_win/2);
        end
    elseif (ix < N_win/2)
        if i_seg_pertr == N_seg_pertr
            data(i_seg, 1:sp, end-ix-(N_win/2-1)+1:end) = test_data(it:end, 1:ix+(N_win/2-1));
        else
            data(i_seg, :, end-ix-(N_win/2-1)+1:end) = test_data(it:it+d_seg-1, 1:ix+(N_win/2-1));
        end       
    elseif (ix > nx-N_win/2)
        if i_seg_pertr == N_seg_pertr
            data(i_seg, 1:sp, 1:nx-ix+N_win/2+1) = test_data(it:end, ix-N_win/2:nx);
        else
            data(i_seg, :, 1:nx-ix+N_win/2+1) = test_data(it:it+d_seg-1, ix-N_win/2:nx);
        end 
    end
end


X_test_1 = data;
save('Data/X_test_1.mat', 'X_test_1', '-v7')

waitfor(gcf);
