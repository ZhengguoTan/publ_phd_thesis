%% Thesis - Multi Echo

%% sim TODO
% rawdata should be arranged according to the radial angle!
% but not the sequence of when spokes are acquired!

%% pha
% % 2015-04-15 res.pha 
op_T11936_grid = multiEchoReco('T11936','2015-04-15', ...
    'mems',0, ...
    'reco','grid', 'gdc',0, 'dc',2);
op_T11941_grid = multiEchoReco('T11941','2015-04-15', ...
    'mems',1, 'travecho',9, 'cf',1,...
    'reco','grid', 'gdc',0, 'dc',2);

T11936_MESS_45S9E_grid = mrIfft(op_T11936_grid.Y0(:,:,:,:,1));
T11941_MEMS_45S9E_grid = mrIfft(op_T11941_grid.Y0(:,:,:,:,1));

T11936_MESS_45S9E_grid = corImgOrien(cropping(sumSqrImg(T11936_MESS_45S9E_grid,3),3));
T11941_MEMS_45S9E_grid = corImgOrien(cropping(sumSqrImg(T11941_MEMS_45S9E_grid,3),3));

T11936_MESS_45S9E_grid_sum = sum(T11936_MESS_45S9E_grid,4) / 9;
T11941_MEMS_45S9E_grid_sum = sum(T11941_MEMS_45S9E_grid,4) / 9;



as(T11936_MESS_45S9E_grid);as(T11941_MEMS_45S9E_grid);
as(T11936_MESS_45S9E_grid_sum);as(T11941_MEMS_45S9E_grid_sum);

%% vol - brain 2015-04-17/T12213 
op_T12213_nlinv = multiEchoReco('T12213','2015-04-17', ...
    'mems',1, 'travecho',15, 'cf',0,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1);

op_T12213_menlinv = multiEchoReco('T12213','2015-04-17', ...
    'mems',1, 'travecho',15, 'cf',1,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1);

T12213_MEMS_375S15E_nlinv = corImgOrien(op_T12213_nlinv.R0(:,:,end));
T12213_MEMS_375S15E_menlinv = corImgOrien(op_T12213_menlinv.R0(:,:,:,end));

as(T12213_MEMS_375S15E_menlinv)

lin = squeeze(T12213_MEMS_375S15E_menlinv(64,110,:));
mag = abs(lin); 
mag = mag ./ max(mag);
phs = angle(lin)*180/pi;

h = figure;
set(h, 'Position',[113 821 260 190])
plot(mag, '-ok', 'LineWidth',2);
set(gca, 'XTickLabel','', 'YTickLabel','',...
        'XTick',[1 5 10 15], 'YTick',[0 0.25 0.5 0.75 1],...
        'LineWidth',2, 'GridLineStyle','-');
xlim([1 15]); ylim([0 1]);
grid on; box on;
set(gca,'position',[0 0 1 1],'units','normalized');

h = figure;
set(h, 'Position',[113 821 260 190])
plot(phs, '-ok', 'LineWidth',2);
set(gca, 'XTickLabel','', 'YTickLabel','',...
        'XTick',[1 5 10 15], 'YTick',[-180 -90 0 90 180],...
        'LineWidth',2, 'GridLineStyle','-');
xlim([1 15]); ylim([-180 180]);
grid on; box on;
set(gca,'position',[0 0 1 1],'units','normalized');


T12213_TE = cooRead('~/Experiments/2015-04-17_MEMS_Brain/T12213-TE-sec.coo');

[T12213_MEMS_375S15E_menlinv_iORC, T12213_map] = ...
    iORC(T12213_MEMS_375S15E_menlinv,T12213_TE',[], 'fittype','nl'); % , ones(224,224));


T12213_MEMS_375S15E_menlinv_sum = sum(T12213_MEMS_375S15E_menlinv,3) / 15;

as(T12213_MEMS_375S15E_nlinv);
as(T12213_MEMS_375S15E_menlinv_sum);
as(T12213_MEMS_375S15E_menlinv_iORC);

%% vol - cardiac
% vol_7595 2015-04-02/T11514
op_T11514_nlinv = multiEchoReco('T11514','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',0,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);

op_T11514_menlinv = multiEchoReco('T11514','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',1,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);

% vol_7595 2015-04-02/T11524
op_T11524_nlinv = multiEchoReco('T11524','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',0,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);

op_T11524_menlinv = multiEchoReco('T11524','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',1,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);


% vol_7595 2015-04-02/T11523
op_T11523_nlinv = multiEchoReco('T11523','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',0,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);

op_T11523_menlinv = multiEchoReco('T11523','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',1,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);

% vol_7595 2015-04-02/T11522
op_T11522_nlinv = multiEchoReco('T11522','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',0,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);

op_T11522_menlinv = multiEchoReco('T11522','2015-04-02', ...
    'mems',1, 'travecho',3, 'cf',1,...
    'reco','nlinv', 'gdc',0, 'dc',0, 'OS',1.5, 'i',7);

% you can load the data from the following directory
cd ~/Publications/Thesis/fig/multi-echo/

T11514_nlinv = cropping(cooRead('T11514-nlinv.coo'),1.5);
T11514_menlinv = cropping(cooRead('T11514-menlinv.coo'),1.5);

T11524_nlinv = cropping(cooRead('T11524-nlinv.coo'),1.5);
T11524_menlinv = cropping(cooRead('T11524-menlinv.coo'),1.5);

T11523_nlinv = cropping(cooRead('T11523-nlinv.coo'),1.5);
T11523_menlinv = cropping(cooRead('T11523-menlinv.coo'),1.5);

T11522_nlinv = cropping(cooRead('T11522-nlinv.coo'),1.5);
T11522_menlinv = cropping(cooRead('T11522-menlinv.coo'),1.5);

as((T11514_menlinv(:,:,1,:) + T11514_menlinv(:,:,2,:))/2); % W
as((T11514_menlinv(:,:,1,:) - T11514_menlinv(:,:,2,:))/2); % F

as(T11514_nlinv, 'title','T11514_nlinv_F76');
as(squeeze(sum(T11514_menlinv,3)), 'title','T11514_menlinv_sum_F76'); % f76

as(T11524_nlinv, 'title','T11524_nlinv_F153');
as(squeeze(sum(T11524_menlinv,3)), 'title','T11524_menlinv_sum_F153'); % f153

as(T11523_nlinv, 'title','T11523_nlinv_F122');
as(squeeze(sum(T11523_menlinv,3)), 'title','T11523_menlinv_sum_F122'); % f122

as(T11522_nlinv, 'title','T11522_nlinv_F221');
as(squeeze(sum(T11522_menlinv,3)), 'title','T11522_menlinv_sum_F221'); % f221

%%