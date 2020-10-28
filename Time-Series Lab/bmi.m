%%Time specifications:
Fs = 100;                   % samples per second
dt = 1/Fs;                  % seconds per sample
StopTime = 10;              % seconds
t = (0:dt:StopTime-dt)';    % seconds

%%Sine wave:
Fc1 = 2;                    % hertz
Fc2 = 5;
Fc3 = 9;
Fc4 = 13;

y1 = sin(2*pi*Fc1*t);
y2 = sin(2*pi*Fc2*t);
y3 = sin(2*pi*Fc3*t);
y4 = sin(2*pi*Fc4*t);
ys = y1 + y2 + y3 + y4;         %sum


% Plot the signal versus time:
% figure;
stackedplot(t, [y1, y2, y3, y4, ys]);
% xlabel('Time(ms)');
% ylabel('Amplitude');
% zoom xon;


% Fourier analysis
yf = fft(ys);
f = (0:length(yf)-1)*Fs/length(yf);
plot(f,abs(yf))
xlabel('Frequency')
ylabel('Power')
xlim([0 30])

% % % % % % % % % % % % % % % % % % 
% B
% add noise
ys_small_noise = ys + 0.1 * gallery('normaldata',size(t), 4);
ys_large_noise = ys + 5 * gallery('normaldata',size(t), 4);
stackedplot(t, [ys, ys_small_noise, ys_large_noise]);
yf1 = fft(ys_small_noise);
yf2 = fft(ys_large_noise);
f = (0:length(y1)-1)*Fs/length(yf1);
plot(f,abs(yf2));
% stackedplot(f, [abs(yf1) abs(yf2)])
xlabel('Frequency')
ylabel('Power')
xlim([0 30])


% % % % % % % % % % % % % % % % % % 
% C
% concat sine waves
% non stationary waves
amplify = 0:5/(length(y1)-1):5;
y_non = [amplify' .* y1; amplify' .* y2; amplify' .* y3; amplify' .* y4];
plot(y_non);
xlabel('Time');
ylabel('Amplitude');

y = fft(y_non);
f = (0:length(y)-1)*Fs/length(y);
plot(f,abs(y))
xlabel('Frequency')
ylabel('Power')
xlim([0 30])


% % % % % % % % % % % % % % % % % % 
% D
% Short-Term Fourier Transform
stft(y_non, seconds(1e-2), 'Window', kaiser(10));
stft(y_non, seconds(1e-2), 'Window', kaiser(100));
stft(y_non, seconds(1e-2), 'Window', kaiser(1000));

% % % % % % % % % % % % % % % % % % 
% E
% eeg data
load('dataset.mat')
eeg = eeg';
y = fft(eeg);
fs = 256;
t = (0:1/fs:(length(eeg)-1)/fs)';
f = (0:length(y)-1)*fs/length(y);

ys_small_noise = eeg + 0.1 * gallery('normaldata',size(t), 4);
ys_large_noise = eeg + 10 * gallery('normaldata',size(t), 4);
stackedplot(t, [eeg, ys_small_noise, ys_large_noise]);

yf1 = fft(ys_small_noise);
yf2 = fft(ys_large_noise);
stackedplot(f, [abs(y) abs(yf1) abs(yf2)])

stft(eeg, fs);
stft(eeg, fs, 'Window', kaiser(100));

