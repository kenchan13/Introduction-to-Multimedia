%%% HW2_Q2.m - bit reduction -> audio dithering -> noise shaping -> low-pass filter -> audio limiting -> normalization
%%% Follow the instructions (hints) and you can finish the homework

%% Clean variables and screen
clear all;close all;clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
[input, fs] = audioread('Tempest.wav');


%%% Plot the spectrum of input audio



%%% Plot the shape of input audio



%% 2. Bit reduction
% (Hint) The input audio signal is double (-1 ~ 1) 



%%% Save audio (audiowrite) Tempest_8bit.wav
% (Hint) remember to save the file with sampling rate = 8



%% 3. Audio dithering
% (Hint) add random noise



%%% Plot the spectrum of the dithered result



%% 4. First-order feedback loop for Noise shaping
% (Hint) Check the signal value. How do I quantize the dithered signal? maybe scale up first?



%%% Plot the spectrum of noise shaping



%% 5. Implement Low-pass filter



%% 6. Audio limiting



%% 7. Normalization



%% 6. Save audio (audiowrite) Tempest_Recover.wav



%%% Plot the spectrum of output audio



%%% Plot the shape of output audio


