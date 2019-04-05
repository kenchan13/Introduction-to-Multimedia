%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.
[frequency, magnitude] = makeSpectrum(y_input, fs);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

%% 2. Filtering 
% (Hint) Implement my_filter here
% [...] = myFilter(...);


%%% Plot the shape of filters in Time domain



%%% Plot the spectrum of filters (Frequency Analysis)



%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter

% audiowrite('FilterName_para1_para2.wav', output_signal1, fs);

%%% Plot the spectrum of filtered signals


%% 4, Reduce the sample rate of the three separated songs to 2kHz.




%% 4. Save the files after changing the sampling rate



%% 5. one-fold echo and multiple-fold echo (slide #69)



%% 5. Save the echo audios  'Echo_one.wav' and 'Echo_multiple.wav'



