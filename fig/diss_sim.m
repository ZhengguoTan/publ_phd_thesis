%% Thesis - Simulations

%% 
load '~/Publications/Thesis/fig/sim-motion/sim-motion.mat'

[Y0,P0] = readRaw(Sim0.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',0);
[R0] = gpunlinv(Y0,P0, '-i6 -o2 -u');
[Y0_dc] = readRaw(Sim0.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2);

[Y0,P0] = readRaw(Sim1.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',0);
[R1] = gpunlinv(Y0,P0, '-i6 -o2 -u');
[Y1_dc] = readRaw(Sim1.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2);

[Y0,P0] = readRaw(Sim2.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',0);
[R2] = gpunlinv(Y0,P0, '-i6 -o2 -u');
[Y2_dc] = readRaw(Sim2.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2);

[Y0,P0] = readRaw(Sim3.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',0);
[R3] = gpunlinv(Y0,P0, '-i6 -o2 -u');
[Y3_dc] = readRaw(Sim3.kdat,0:4, 'gdc',0, 'npc',-1, 'dcf',2);

as(R0);as(R1);as(R2);as(R3);
as(Y0_dc);as(Y1_dc);as(Y2_dc);as(Y3_dc);

%%