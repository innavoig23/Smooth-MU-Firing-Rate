%% Load
clearvars
close all
clc

load './exMUPulses.mat';
fsamp = 2048; % the signals of the example was acquired ad 2048 Hz
sigLen = 30 * fsamp; % the duration of the acquisition was 30 s
numMUs = numel(MUPulses); % number of identified MUs (here I extracted only 2 MUs for simplicity)

%% Compute IDR and smooth it
% IDR
IDR = cellfun(@(x) fsamp./diff(x), MUPulses, 'UniformOutput',false);
timeInst = cellfun(@(x) x(2:end)/fsamp, MUPulses, 'UniformOutput',false);

% Smoothed IDR
smoothedIDR = smoothFiringRateMU(MUPulses, fsamp, sigLen);
timeSmoothed = (0:length(smoothedIDR(1,:))-1) / fsamp;

%% Plot
matBlue = [0 0.4470 0.7410]; % blue for plot
matRed = [0.8500 0.3250 0.0980]; % red for plot

for mu = 1:numMUs

    % Figure Creation
    figure('Name', sprintf("MU %d - Firing Rate", mu), 'WindowState', 'maximized');
    
    % IDR and Smoothed IDR Plot
    yyaxis left
    scatter(timeInst{mu}, IDR{mu}, 'LineWidth', 1, 'MarkerEdgeColor', matBlue)
    hold on;
    plot(timeSmoothed, smoothedIDR(mu, :), 'LineWidth', 2, 'Color', matBlue*1.1, 'LineStyle', '-');
    ylabel('Discharge Rate (pps)', 'FontWeight', 'bold')
    
    % Force Plot
    yyaxis right
    plot(timeSmoothed, forceSig*100, 'LineWidth', 2, 'Color', matRed, 'LineStyle', '-');
    ylabel('Force (% MVC)', 'FontWeight', 'bold')
    ylim([0 25])
    
    % Plot Settings
    xlim([timeSmoothed(1), timeSmoothed(end)+1/fsamp])
    xlabel('Time (s)', 'FontWeight', 'bold')

    set(gca, 'FontSize', 24);
    title(sprintf("MU %d - Firing Rate", mu), 'FontWeight', 'bold', 'FontSize',26)

    legend('IDR', 'Smoothed IDR')

end
