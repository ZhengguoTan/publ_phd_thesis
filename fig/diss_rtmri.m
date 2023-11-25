%% Thesis - rtmri - pc

%% phase evolution along gradients
close all;
N   = 100;
tau = 4;
li  = ones(1,N);
inc = 1;
t   = 1 : inc : N*tau;

G0  = 1;
GFC = [G0*li, -G0*li, -G0*li, G0*li];

phi_FC_0 = GFC(1)*inc*ones(1,length(GFC));
phi_FC_v = GFC(1)*t(1)*inc*ones(1,length(GFC));
for n = 2 : length(GFC)
    phi_FC_0(1,n) = phi_FC_0(1,n-1) + GFC(n)*inc;
    phi_FC_v(1,n) = phi_FC_v(1,n-1) + GFC(n)*t(n)*inc;
end


GFE = [G0*li, -G0*li];

phi_FE_0 = GFE(1)*inc*ones(1,length(GFE));
phi_FE_v = GFE(1)*t(1)*inc*ones(1,length(GFE));

for n = 2 : length(GFE)
    phi_FE_0(1,n) = phi_FE_0(1,n-1) + GFE(n)*inc;
    phi_FE_v(1,n) = phi_FE_v(1,n-1) + GFE(n)*t(n)*inc;
end

figure; 

min_0 = min([phi_FC_0, phi_FE_0]);
max_0 = max([phi_FC_0, phi_FE_0]);

min_v = min([phi_FC_v, phi_FE_v]);
max_v = max([phi_FC_v, phi_FE_v]);


subplot(321); plot(t(1:length(GFC)), phi_FC_0); xlim([0 length(GFC)]);ylim([min_0 max_0])
subplot(323); plot(t(1:length(GFC)), phi_FC_v); xlim([0 length(GFC)]);ylim([min_v max_v])

subplot(322); plot(t(1:length(GFE)), phi_FE_0); xlim([0 length(GFE)]);ylim([min_0 max_0])
subplot(324); plot(t(1:length(GFE)), phi_FE_v); xlim([0 length(GFE)]);ylim([min_v max_v])

%%