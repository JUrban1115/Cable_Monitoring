% Script to generate time and frequency domain plots, where t_sample
% represents total sampling time. Paste into console to use.

[Xsize,Ysize]=size(A);
t_sample=Tinterval*Length;
t1=((1/Xsize):(t_sample/Xsize):t_sample);
    %is +Tinterval correct?
%t1=(0:(t_sample/Xsize):t_sample);
plot(t1,A);


%Taking/plotting the Fourier Transform of input data
Fs=1/Tinterval;
Ts=Tinterval;
t2=0:Ts:t_sample-Ts;
n=length(t2);
y=A;
plot(t2,y);

figure;
[YfreqDomain,frequencyRange]=positiveFFT(y,Fs);
stem(frequencyRange,abs(YfreqDomain));
xlabel('Freq (Hz)')
ylabel('Amplitude')
title('using positiveFFT')
grid
axis([0,50,0,.0001])
axis 'auto y'