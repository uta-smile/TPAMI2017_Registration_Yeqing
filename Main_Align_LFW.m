function Main_Align_LFW(fold_idx, type)
% Align raw lfw-crop images for face recognition task.
% Using SSD, RC, HSR.
% type = 'TRANSLATION' or 'AFFINE'

addpath(genpath('.'))
dbstop if error

% Main settings
main.similarity='dtv';   % similarity measure, e.g. SSD, CC, SAD, RC, CD2, MS, MI
% main.type = 'AFFINE'; % or TRANSLATION
main.type = type;
% main.mu=0.01;        % similarity measure parameter (e.g., alpha of RC)
main.TV = TVOP;
main.subdivide=3;       % use 3 hierarchical levels
% main.okno=8;            % mesh window size, the smaller it is the more complex deformations are possible
% main.lambda = 0.005;    % transformation regularization weight, 0 for none
main.single=0;          % show mesh transformation at every iteration
main.alpha = 0.05;
% main.initialX = [1.00 0.10 -5;
%        -0.10 1.00 -0;
%        0 0 1];
% Optimization settings
optim.maxsteps = 200;   % maximum number of iterations at each hierarchical level
optim.fundif = 1e-6;    % tolerance (stopping criterion)
optim.gamma = 1;       % initial optimization step size
optim.anneal=0.8;       % annealing rate on the optimization step

t0= cputime();
tic;
for subset = {'train', 'test'},
    disp(subset);
    filename = sprintf('lfwcrop_view2_%s_f%d.mat', subset{1}, fold_idx);
    disp(filename);
    [x, y] = read_lfw(filename);
    
    x_ssd = x; %cell(size(x));
    x_rc = x; %cell(size(x));
    x_dtv = x; %cell(size(x));
    
    sz = size(x);
    parfor i=1:min(2, sz(2)),
        i
        refim = double(squeeze(x{1, i}));
        im = double(squeeze(x{2, i}));
        
        main_in = main;
        main_in.similarity='dtv';
        tic;
        [res1, newim1]=mirt2D_register_rigid(refim,im, main_in, optim);
        t_dtv = toc;
        
        %%
        main_in.similarity='rc';
        tic;
        [res2, newim2]=mirt2D_register_rigid(refim,im, main_in, optim);
        t_rc = toc;
        
        %%
        main_in.similarity='ssd';
        tic;
        [res3, newim3]=mirt2D_register_rigid(refim,im, main_in, optim);
        t_ssd = toc;
        
        refim = double(squeeze(x{1, i}));
        im = double(squeeze(x{2, i}));
        
        %x_ssd{1, i} = refim;
        x_ssd{2, i} = newim3;
        %x_rc{1, i} = refim;
        x_rc{2, i} = newim2;
        %x_dtv{1, i} = refim;
        x_dtv{2, i} = newim1;
        
%         figure(1); imshowpair(im, refim,'falsecolor');  title('noregistration');
%         figure(2); imshowpair(newim3, refim,'falsecolor'); title('ssd');
%         figure(3); imshowpair(newim2, refim,'falsecolor'); title('RC');
%         figure(4); imshowpair(newim1, refim,'falsecolor');  title('DTV');
        
        fprintf('SSD: mean running time: %f\n',t_ssd);
        fprintf('RC: mean running time: %f\n',t_rc);
        fprintf('DTV: mean running time: %f\n',t_dtv);
        
    end
    
    x = x_ssd;
    save(sprintf(fullfile('data', 'lfw', ...
        'lfwcrop_view2_%s_f%d_align_ssd_trans.mat'), ...
        subset{1}, fold_idx), 'x', 'y')
    x = x_rc;
    save(sprintf(fullfile('data', 'lfw', ...
        'lfwcrop_view2_%s_f%d_align_rc_trans.mat'), ...
        subset{1}, fold_idx), 'x', 'y')
    x = x_dtv;
    save(sprintf(fullfile('data', 'lfw', ...
        'lfwcrop_view2_%s_f%d_align_dtv_trans.mat'), ...
        subset{1}, fold_idx), 'x', 'y')
    
end
toc
t_elapse = cputime()-t0