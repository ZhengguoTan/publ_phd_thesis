%% Thesis - Asymmetric Echo

%% asym-echo k-space
plottrj(4);

%% asym-echo psf
load '~/Publications/Thesis/fig/asym-echo/psf.mat';

[Y_s125] = readRaw(Sim1.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2, ...
    'asym',size(Sim1.kdat,1)/256);
Y_s125 = sum(Y_s125,5) / 5;

[Y_s65] = readRaw(Sim2.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2, ...
    'asym',size(Sim2.kdat,1)/256);
Y_s65 = sum(Y_s65,5) / 5;

[Y_s35] = readRaw(Sim3.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2, ...
    'asym',size(Sim3.kdat,1)/256);
Y_s35 = sum(Y_s35,5) / 5;

cnt = 0;
clear kdat v Y
for a = 0.4 : -0.1 : 0.2
    cnt = cnt + 1;
    fullSmp = size(Sim2.kdat,1);
    v = full2asym(fullSmp, a, 's');
    kdat = Sim1.kdat(v(1):end,:,:,:,:);
    [Y(:,:,:,:,:,cnt)] = readRaw(kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2, ...
        'asym',size(kdat,1)/fullSmp);
end

Y_s125_as40 = Y(:,:,:,:,:,1);
Y_s125_as40 = sum(Y_s125_as40,5)/5;

Y_s125_as30 = Y(:,:,:,:,:,2);
Y_s125_as30 = sum(Y_s125_as30,5)/5;

Y_s125_as20 = Y(:,:,:,:,:,3);
Y_s125_as20 = sum(Y_s125_as20,5)/5;

as(Y_s125); as(Y_s65); as(Y_s35);
as(Y_s125_as40); as(Y_s125_as30); as(Y_s125_as20);

%% asym-echo spatial resolution
op_as50 = recoAsymEcho('T6238', '2014-12-02');

% gradient delay coefficients from symmetric echo: 
gdc   = [0.214 -0.176 0.014];
Ar_50 = op_as50.dat;

cnt = 0;
for a = 0.4 : -0.1 : 0.2
    cnt = cnt + 1;
    fullSmp = size(Ar_50,1);
    v = full2asym(fullSmp, a, 's');
    kdat = Ar_50(v(1):end,:,:,:,:);
    [Y0,P0] = readRaw(kdat,0:4, 'gdc', gdc,'asym',size(kdat,1)/fullSmp);
    [R(:,:,:,cnt)] = gpunlinv(Y0,P0, '-i6 -o2 -u');
end

R_arti50 = op_as50.R0;
R_arti40 = R(:,:,:,1);
R_arti30 = R(:,:,:,2);
R_arti20 = R(:,:,:,3);

op_as40 = recoAsymEcho('T6239', '2014-12-02');
op_as30 = recoAsymEcho('T6240', '2014-12-02');
op_as20 = recoAsymEcho('T6241', '2014-12-02');

as(R_arti50);
as(R_arti40);as(R_arti30);as(R_arti20);
as(op_as40.R0, 'title','R_res_as40');
as(op_as30.R0, 'title','R_res_as30');
as(op_as20.R0, 'title','R_res_as20');

%% asym-echo reco - SL phantom - 17 spokes, br 256, 10 coils
clear R*

load '~/Publications/Thesis/fig/asym-echo/SL_phs_as50.mat'
kdat = Sim0.kdat;
kdat = kdat * 3e3/ norm(kdat(:));

asym = [0.5 0.1]; % 0.5 : -0.1 : 0.1;

R      = zeros([size(kdat,1)*1.5/2, size(kdat,1)*1.5/2, size(kdat,5), length(asym)]);
R_pocs = zeros([size(kdat,1)*1.5/2, size(kdat,1)*1.5/2, size(kdat,5), length(asym)]);

cnt = 0;
for a = asym
    cnt = cnt + 1;
    fullSmp = size(Sim0.kdat,1);
    v = full2asym(fullSmp, a, 's');
    Ar = kdat(v,:,:,:,:);
    Ar = gaussnoise(Ar,0,0.01,1);
    [Y0,P0] = readRaw(Ar,0:4, 'gdc',0, 'npc',-1, 'dcf',0, ...
                'asym',size(Ar,1)/fullSmp);
    [R(:,:,:,cnt)] = gpunlinv(Y0,P0, '-i6 -o2 -u');
    
    if a ~= 0.5
        sz = size(Ar);
        Br = zeros([fullSmp, sz(2:end)]);
        Br(v,:,:,:,:) = Ar;
        Br_pocs = POCS1(Br);
        [Y0,P0] = readRaw(Br_pocs,0:4, 'gdc',0, 'npc',-1, 'dcf',0, ...
            'asym',size(Br_pocs,1)/fullSmp);
        [R_pocs(:,:,:,cnt)] = gpunlinv(Y0,P0, '-i6 -o2 -u');
    end
end

clear fullSmp v Y0 P0
disp('finished!');

%% asym-echo reco - cardiac short axis
op_as50 = recoAsymEcho('T27128', '2014-05-27'); % as50
op_as40 = recoAsymEcho('T27129', '2014-05-27'); % as40
op_as30 = recoAsymEcho('T27130', '2014-05-27'); % as30
op_as20 = recoAsymEcho('T27131', '2014-05-27'); % as20

as(op_as50.R0); as(op_as40.R0); as(op_as30.R0); as(op_as20.R0);

%% experiments - flow phantom
% ==============================================
op_T6280 = phaseContrast('T6280', '2014-12-02');
op_T6281 = phaseContrast('T6281', '2014-12-02');

op_T6273 = phaseContrast('T6273', '2014-12-02');
op_T6277 = phaseContrast('T6277', '2014-12-02');

% ==============================================
cd ~/Experiments/2014-12-02_PC_pha/pha_2431/

pc_T6273 = cooRead('T6273-nlinv-pc.coo');
pc_T6277 = cooRead('T6277-nlinv-pc.coo');

pc_T6280 = cooRead('T6280-nlinv-pc.coo');
pc_T6281 = cooRead('T6281-nlinv-pc.coo');

%% experiments - aorta



