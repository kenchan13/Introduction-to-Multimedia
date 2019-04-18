%%% HW2_Q2.m - bit reduction -> audio dithering -> noise shaping -> low-pass filter -> audio limiting -> normalization
%%% Follow the instructions (hints) and you can finish the homework

%% Clean variables and screen
clear all;
close all;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% Get input data wihtout normatization
% Great for bit reduction
[input, fs] = audioread('Tempest.wav');

% Plot in full screen
figure('units','normalized','outerposition',[0 0 1 1]);

%%% Plot the shape of input audio
subplot(4,2,1);
plot(input, 'LineWidth', LineWidth); 
title('Shape of Input Audio', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
% xlim([100 1600]);
ylim([-1 2]);

%%% Plot the spectrum of input audio
subplot(4,2,2);
[frequency, magnitude] = makeSpectrum(input, fs);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Spectrum of Input Audio', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([50 5000]);

%% 2. Bit reduction
% (Hint) The input audio signal is double (-1 ~ 1)
input8bits = uint8( (input + 1)/2 * 255 );

%%% Save audio (audiowrite) Tempest_8bit.wav
% (Hint) remember to save the file with sampling rate = 8
audiowrite('Tempest_8bit.wav', input8bits, fs, 'BitsPerSample', 8);

%%% Plot the shape of the Bit reduction
% subplot(4,3,1);
% [freq_8bit, mang_8bit] = makeSpectrum(input8bits, fs);
% plot(freq_8bit, mang_8bit, 'LineWidth', LineWidth); 
% title('Shape of Bit Reduction', 'fontsize', titlefont);
% set(gca, 'fontsize', fontsize);
% xlim([50 2000]);
% ylim([0 10^5]);

%% 3. Audio dithering
% (Hint) add random noise
[input8bits_nor, fs_nor] = audioread('Tempest_8bit.wav');
input8bits_dither = input8bits_nor + rand(size(input8bits_nor))/2;

%%% Plot the shape of the dithered result
subplot(4,2,3);
plot(input8bits_dither, 'LineWidth', LineWidth); 
title('Shape of Dithered Result', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
xlim([0 inf]);
ylim([-1 2]);

%%% Plot the spectrum of the dithered result
subplot(4,2,4);
[freq_dither, mang_dither] = makeSpectrum(input8bits_dither, fs_nor);
plot(freq_dither, mang_dither, 'LineWidth', LineWidth); 
title('Spectrum of Dithered Result', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
xlim([50 4000]);
% ylim([0 10^5]);

% sound(input8bits_dither, fs_nor);

%% 4. First-order feedback loop for Noise shaping
% (Hint) Check the signal value. How do I quantize the dithered signal? maybe scale up first?
[row, col] = size(input8bits_dither);
shapingOutput = input8bits_dither;
c = 0.7;

for C = 1: col
    for R = 1: row
        if (R-1 >= 1)
            shapingOutput(R, C) = shapingOutput(R, C)+ c*(input8bits_nor(R-1,C)-shapingOutput(R-1,C));
        end
    end
end

% sound(shapingOutput, fs_nor);

%%% Plot the shape of noise shapping
subplot(4,2,5);
plot(shapingOutput, 'LineWidth', LineWidth); 
title('Shape of Noise Shaping', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
xlim([0 inf]);
ylim([-1 2]);

%%% Plot the spectrum of noise shaping
subplot(4,2,6);
[freq_shaping, mang_shaping] = makeSpectrum(shapingOutput, fs_nor);
plot(freq_shaping, mang_shaping, 'LineWidth', LineWidth); 
title('Spectrum of Noise Shaping', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
xlim([50 4000]);
% ylim([0 10^5]);


%% 5. Implement Low-pass filter
N = 1999;
fcutoff1 = 1500;
fcutoff2 = 0;
filterName = 'low-pass';
[lowpassOutput, outputFilter] = myFilter(shapingOutput, fs_nor, N, 'Blackman', filterName, fcutoff1, fcutoff2);

% sound(lowpassOutput, fs_nor);

%% 6. Audio limiting(hard clipping)
limitingOutput = lowpassOutput;
[row, col] = size(lowpassOutput);
for R = 1: row
    for C = 1:col
        if limitingOutput(R, C) >= 0.06
            limitingOutput(R, C) = 0.06;
        elseif limitingOutput(R, C) < 0
            limitingOutput(R, C) = 0;
        end
    end
end

% sound(limitingOutput, fs);

%% 7. Normalization

desireMax = .5;
for C = 1: col
   ampM = max(limitingOutput(:,C));
   normalizeOutput(:,C) = limitingOutput(:,C)*(desireMax/ampM);
end

% sound(normalizeOutput, fs);

%% 6. Save audio (audiowrite) Tempest_Recover.wav
audiowrite('Tempest_Recover.wav', normalizeOutput, fs);

%%% Plot the shape of output audio
subplot(4,2,7);
plot(normalizeOutput, 'LineWidth', LineWidth); 
title('Shape of Output Audio', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
% xlim([0 5000]);

%%% Plot the spectrum of output audio
subplot(4,2,8);
[normalizeFreq, normalizeMag] = makeSpectrum(normalizeOutput, fs);
plot(normalizeFreq, normalizeMag, 'LineWidth', LineWidth); 
title('Spectrum of Output Audio', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([50 4000]);
