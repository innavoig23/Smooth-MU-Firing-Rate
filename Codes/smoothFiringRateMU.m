function sIDR = smoothFiringRateMU(MUPulses, fsamp, sigLen)
% SMOOTHFIRINGRATEMU Computes the smoothed firing rate of motor units.
%
% This function takes a set of motor unit pulse trains (typically obtained 
% after EMG decomposition) and applies a 400 ms Hanning window to smooth 
% the instantaneous discharge rate (IDR). 
%
% This smoothing approach has been classically applied in the literature 
% to analyze the time-varying behavior of motor units after decomposition, 
% as introduced by De Luca et al. (1982) [1].
%
% INPUTS:
%   - MUPulses : cell array {1xnumMUs}, each cell contains a vector of 
%                spike times (in samples) for a given motor unit.
%   - fsamp    : scalar, sampling frequency of the EMG signal (Hz).
%   - sigLen   : scalar, total length of the signal in samples.
%
% OUTPUT:
%   - sIDR     : matrix [numMUs x sigLen], smoothed IDR for each MU.
%
% REFERENCES:
%   [1] De Luca, C. J., LeFever, R. S., McCue, M. P., & Xenakis, A. P. (1982). 
%       Behaviour of human motor units in different muscles during linearly 
%       varying contractions. The Journal of Physiology, 329(1), 113–128. 
%       DOI: 10.1113/jphysiol.1982.sp014293
%
% Author: Giovanni Traetta
% Date: 11 Feb 2025

%% Initialization
numMUs = numel(MUPulses); % Number of motor units

% Define Hanning window for smoothing (400 ms window)
winLen = 0.4; % window length in seconds
winLen = round(winLen * fsamp); % window length in samples
hanningWin = hanning(winLen); % create Hanning window
hanningWin = hanningWin / sum(hanningWin); % normalize energy to maintain correct scaling

% If `sigLen` is not provided, set it to the last firing instant instant among MUs
if nargin < 3
    sigLen = max(cellfun(@max, MUPulses)) + 1; % ensure signal length includes last MU spike
end

% Preallocate output
sIDR = zeros(numMUs, sigLen); 

%% Smooth IDR
% Loop through each MU
for mu = 1:numMUs

    % Check if the MU has at least two spikes to compute IDR
    % Note: This check is redundant, as MUs firing pattern is usually checked right after decomposition. 
    if numel(MUPulses{mu}) < 2
        sIDR(mu, :) = NaN(1, sigLen); % assign NaN to indicate insufficient data
        continue;
    end

    % Convert spike times into a binary pulse train
    pulses = zeros(1, sigLen);
    pulses(MUPulses{mu}) = 1;

    % Apply convolution with Hanning window to smooth IDR
    sIDR(mu, :) = conv(pulses, hanningWin, 'same') * fsamp; % compute and scale to pps

end
