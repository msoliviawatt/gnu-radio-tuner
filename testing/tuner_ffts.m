%% MITRE 2025 - Olivia Watt
% MATLAB file for tuner concept testing
close all;
clear;
clc;

% some parameters
Fs = 32e3; % sample rate
fft_size = 1024;
T = 1 / Fs;
duration = 2;
t = 0:1/Fs:duration - 1/Fs;


% change these as needed
tone = sin(2 * pi * 440 * t); % note to tune to
input1 = 600; % too high
input2 = 500; % slightly high
input3 = 440; % perfectly in tune
input4 = 300; % low

N = length(tone);

mix1 = tone .* sin(2 * pi * input1 * t);
mix2 = tone .* sin(2 * pi * input2 * t);
mix3 = tone .* sin(2 * pi * input3 * t);
mix4 = tone .* sin(2 * pi * input4 * t);

% ffts
Y0 = fft(tone);
Y1 = fft(mix1);
Y2 = fft(mix2);
Y3 = fft(mix3);
Y4 = fft(mix4);

f = (0:N - 1) * (Fs / N);

figure(1);
% plot(Fs / L * (0:L - 1), abs(fftshift(Y1)), "LineWidth", 2)
Y1_mag = abs(Y1);
plot(f(1:N/2), Y1_mag(1:N/2))
title("FFT for Tuning Too High")
xlabel("f (Hz)")
ylabel("|fft(X)|")

figure(2);
% plot(Fs / L * (0:L - 1), abs(fftshift(Y2)), "LineWidth", 2)
Y2_mag = abs(Y2);
plot(f(1:N/2), Y2_mag(1:N/2))
title("FFT for Tuning Slightly High")
xlabel("f (Hz)")
ylabel("|fft(X)|")

figure(3);
% plot(Fs / L * (0:L - 1), abs(fftshift(Y3)), "LineWidth", 2)
Y3_mag = abs(Y3);
plot(f(1:N/2), Y3_mag(1:N/2))
title("FFT for Perfectly Tuned")
xlabel("f (Hz)")
ylabel("|fft(X)|")

figure(4);
% plot(Fs / L * (0:L - 1), abs(fftshift(Y4)), "LineWidth", 2)
Y4_mag = abs(Y4);
plot(f(1:N/2), Y4_mag(1:N/2))
title("FFT for Tuning Too Low")
xlabel("f (Hz)")
ylabel("|fft(X)|")

figure(5)
% plot(Fs / L * (0:L - 1), abs(fftshift(Y0)), "LineWidth", 2)
Y0_mag = abs(Y0);
plot(f(1:N/2), Y0_mag(1:N/2))
title("FFT for Tone")
xlabel("f (Hz)")
ylabel("|fft(X)|")