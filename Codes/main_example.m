%% Load
clearvars
close all
clc

load './exMUPulses.mat';
fsamp = 2048; % the signals of the example was acquired ad 2048 Hz
sigLen = 30 * fsamp; % the duration of the acquisition was 30 s
numMUs = numel(MUPulses);

%% Compute IDR and smooth it
IDR = cellfun(@(x) fsamp./diff(x), MUPulses, 'UniformOutput',false);
timeInst = cellfun(@(x) x(2:end)/fsamp, MUPulses, 'UniformOutput',false);

smoothedIDR = smoothFiringRateMU(MUPulses, fsamp, sigLen);
timeSmoothed = (0:length(smoothedIDR(1,:))-1) / fsamp;

%% Plot
matBlue = [0 0.4470 0.7410];
matRed = [0.8500 0.3250 0.0980];

for mu = 1:numMUs

    figure('Name', sprintf("MU %d - Firing Rate", mu), 'WindowState', 'maximized');
    
    yyaxis left
    scatter(timeInst{mu}, IDR{mu}, 'LineWidth', 1, 'MarkerEdgeColor', matBlue)
    hold on;
    plot(timeSmoothed, smoothedIDR(mu, :), 'LineWidth', 2, 'Color', matBlue*1.1, 'LineStyle', '-'); % Forza linea continua
    ylabel('Discharge Rate (pps)', 'FontWeight', 'bold')
    
    yyaxis right
    plot(timeSmoothed, forceSig*100, 'LineWidth', 2, 'Color', matRed, 'LineStyle', '-'); % Assicura linea continua
    ylabel('Force (% MVC)', 'FontWeight', 'bold')
    
    xlim([timeSmoothed(1), timeSmoothed(end)])

    set(gca, 'FontSize', 24);
    title(sprintf("MU %d - Firing Rate", mu), 'FontWeight', 'bold', 'FontSize',26)

    legend('IDR', 'Smoothed IDR')

end

%% Plot
matBlue = [0 0.4470 0.7410];
matRed = [0.8500 0.3250 0.0980];

figure('Name','MUs Firing Rate', 'WindowState','maximized');
sgtitle('MUs Firing Rate', 'FontWeight', 'bold', 'FontSize',26)

for mu = 1:numMUs

    subplot(2,1,mu)

    yyaxis left
    scatter(timeInst{mu}, IDR{mu}, 'LineWidth', 1, 'MarkerEdgeColor', matBlue)
    hold on;
    plot(timeSmoothed, smoothedIDR(mu, :), 'LineWidth', 2, 'Color', matBlue*1.1, 'LineStyle', '-'); % Forza linea continua
    ylabel('Discharge Rate (pps)', 'FontWeight', 'bold')
    
    yyaxis right
    plot(timeSmoothed, forceSig*100, 'LineWidth', 2, 'Color', matRed, 'LineStyle', '-'); % Assicura linea continua
    ylabel('Force (% MVC)', 'FontWeight', 'bold')
    
    xlim([timeSmoothed(1), timeSmoothed(end)])

    set(gca, 'FontSize', 24);
    title(sprintf("MU %d", mu), 'FontWeight', 'bold', 'FontSize',26)

    legend('IDR', 'Smoothed IDR')

end
