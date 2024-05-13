clc, clear, close all
fs = 100;
Ts = 1/fs;
ts = 1 / fs;
T = 1;

fc=5;
t_start = 0;
t_end = T;
t = t_start:Ts:t_end-Ts;
N = length(t);
f = (-fs / 2):(fs / N):(fs / 2 - fs / N);
beta = 0.3;      

%%  p1.1
sentSignal=cos(2*pi*fc*t);
plot(t, sentSignal);
title('cos(2\pi 100t)')
xlabel('time')

%% p1.2
V=50;
R=250000;
B=0.3;
A=0.5;
C=3e8 ;
p=2/C;
fd=B*V;
td=R*p;
recvSignal=A*cos(2*pi*(fc+fd)*(t-td));
plot(t,recvSignal);
title('\alpha cos(2\pi(fc+fd)(t-td))')
xlabel('time')

%% p1.3
N = length(t);
fm=100;
f = (-fm / 2):(fm / N):(fs / 2 - fm / N);
y=fftshift(fft(recvSignal));
F=y/max(abs(y));

subplot(1,2,1);
plot(f,abs(F));

to1=1e-6;
F(abs(F)<to1)=0;
theta = angle(F);
subplot(1,2,2);
plot(f,theta/pi);

maxVal = max(abs(F));
maxPos = find(abs(F) == maxVal, 1, 'last') - 51;
found_fd= maxPos - fc
[~, maxIndex] = max(F);
found_td = theta(maxIndex)/(2*pi*(found_fd+fc));
found_V = found_fd/B;
found_R = (found_td*C)/2;

 disp(['P1.3: Estimated V is:',num2str(found_V*3.6),' and estimated R is:',num2str(found_R/1000)]);

%% p1.4
threshold = 6; 
for noise_level = 0:0.3:threshold
    x_noisy = recvSignal + noise_level * randn(size(recvSignal));    
    X_noisy = fftshift(fft(x_noisy));
    X_noisy = X_noisy/max(abs(X_noisy));    
    figure;
    subplot(2,1,1);
    plot(t, x_noisy);
    title(['Noisy Signal (Noise Level = ' num2str(noise_level) ')']);
    
    subplot(2,1,2);
    plot(f, abs(X_noisy));
    title(['Magnitude Spectrum (Noise Level = ' num2str(noise_level) ')']);
    
    maxVal = max(abs(X_noisy));
    maxPos = find(abs(X_noisy) == maxVal, 1, 'last') - 51;
    found_fd1= maxPos - fc;
    
    [~, maxIndex] = max(X_noisy);
    found_td1 = theta(maxIndex)/(2*pi*(found_fd1+fc));
    found_V1 = found_fd1/B;
    found_R1 = (found_td1*C)/2;
    if found_V1 ~= found_V
            disp(['change at V. Noise level at: ' num2str(noise_level)]);
            break;
    end
    if found_R1 ~= found_R
        disp(['change at R. Noise level at: ' num2str(noise_level)]);
        break;
    end    
%     pause(1);
end

%% p1.5

V1 = 50;
R1 = 250000;
alpha1 = 0.5;
td1 = (2*R1)/C;
fd1 = B*V1;
x_1 = alpha1*cos(2*pi*(fc+fd1)*(t-td1));

V2 = 60;       
R2 = 200000;
alpha2 = 0.6;
td2 = (2*R2)/C;
fd2 = B*V2;
x_2 = alpha2 * cos(2 * pi * (fc+fd2) * (t-td2));

recived_sig = x_1+x_2;
figure
plot(t, recived_sig)
title('\alpha cos(2\pi(fc+fd)(t-td))')
xlabel('time')

%% p1.6

y6 = fftshift(fft(recived_sig));
sig_fft2 = abs(y6) / max(abs(y6));
[peak,x_peaks]= findpeaks(abs(sig_fft2));
[peak,index]=sort(peak,'descend');
x_peaks = x_peaks(index);
sig_phase = angle(y6);

found_fd_1=abs(x_peaks(2*1)-fs/2-1)-fc;
found_td_1 = abs((sig_phase(x_peaks(2*1)))/(2*pi*(found_fd_1+fc)));
Vrecv1 = found_fd_1/B;
Rrecv1 = (found_td_1/(2/C));
 disp(['P1.6: Estimated V1 is:',num2str(Vrecv1*3.6),' and estimated R1 is:',num2str(Rrecv1/1000)]);
 
found_fd_2=abs(x_peaks(2*2)-fs/2-1)-fc;
found_td_2 = abs((sig_phase(x_peaks(2*2)))/(2*pi*(found_fd_2+fc)));
Vrecv2 = found_fd_2/B;
Rrecv2 = (found_td_2/(2/C));
 disp(['P1.6: Estimated V2 is:',num2str(Vrecv2*3.6),' and estimated R2 is:',num2str(Rrecv2/1000)]);

