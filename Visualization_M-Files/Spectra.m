% Spectra: Generates Freq Spectra

function [ YFreqDomain, frequencyRange ] = Spectra( A, Tinterval, Length )

%Plots input over time, where t_sample represents total sampling time
[Xsize,Ysize]=size(A);
t_sample=Tinterval*Length;
t1=((1/Xsize):(t_sample/Xsize):t_sample);
    %is +Tinterval correct?
%t1=(0:(t_sample/Xsize):t_sample);


%Taking/plotting the Fourier Transform of input data
Fs=1/Tinterval;
Ts=Tinterval;
t2=0:Ts:t_sample-Ts;
n=length(t2);
y=A;

[YfreqDomain,frequencyRange]=positiveFFT(y,Fs);
YfreqDomain = abs(YfreqDomain);