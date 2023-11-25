%% Thesis - MRI

%% FID
T2s = 50; % ms
fre = 100 * 1e-3; % kHz

t   = 0 : .2 : 240; % ms
dey = exp(-t/T2s);
fid = sin(2*pi * fre * t) .* dey;


h = figure; hold all; axis off;
set(h,'Color','k') % 'w'
plot(t, fid, 'Color', 'w', 'LineWidth',2);
plot(t, dey, '--', 'Color', 'w', 'LineWidth',2);
plot(t,-dey, '--', 'Color', 'w', 'LineWidth',2);

set(h, 'Position',[113 821 360 180])
set(gca, 'XTickLabel','', 'YTickLabel','');

set(gca,'position',[0 0 1 1],'units','normalized');


%% 
I = imread('~/Publications/Thesis/fig/mri-pi/mri-brain.png');

% I = imresize(I, 0.5);
[NX,NY] = size(I);
iptsetpref('ImshowBorder','tight');
h = figure; hold all; axis tight;
imshow(I);

N = 13;
xline = linspace(1,NX,N);
yline = linspace(1,NY,N);
for n = 1 : 1 : N
    line([xline(1) xline(end)],[xline(n) xline(n)], 'color',[1 1 1])
    line([yline(n) yline(n)],[yline(1) yline(end)], 'color',[1 1 1])
end




%% parallel imaging
rphan = cPhan('SL',256,0);
K0    = rphan.analKsp;
I0    = mrIfft(K0);

NC   = 4;
coil = init_coil(NC, 256, 'biot', 256);
R    = 2;

for n = 1 : NC
    C = coil.sensitivity(:,:,n);
    K = mrFft(I0.*C);
    K = K(1:2:end,:);
    I(:,:,n) = mrIfft(K);
end

as(I0); as(I); as(coil.sensitivity);

%%