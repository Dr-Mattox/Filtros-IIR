clc; clear;

% Parámetros del filtro
Fs = 1291.32/2;     % Frecuencia de muestreo (Hz)
Fo = 100;         % Frecuencia central (Hz)
Fb = 50;          % Ancho de banda (Hz)

% Cálculo de frecuencias análogas
Omega0 = 2 * Fs * tan(pi * Fo / Fs);   % Frecuencia central analógica
Omegab = 2 * Fs * tan(pi * Fb / Fs);   % Ancho de banda analógica

% Coeficientes normalizados (según fórmulas del documento, pág. 223)
den = (4*Fs^2 + 2*Fs*Omegab + Omega0^2);

a1 = (4 * Fs^2 + Omega0^2) / den;
a2 =  (2*Omega0^2 - 8*Fs^2) / den;
a3 = a1;

b1 = 1;  % coeficiente normalizado
b2 = a2;
b3 = (4 * Fs^2 - 2 * Fs * Omegab + Omega0^2) / den;

% Mostrar resultados
fprintf('\n// ----- Coeficientes exportados para Arduino IDE -----\n');
fprintf('// Rechaza banda: Fo = %.2f Hz | Fb = %.2f Hz | Fs = %.2f Hz\n', Fo, Fb, Fs);
fprintf('float a1 = %.15f;\n', a1);
fprintf('float a2 = %.15f;\n', a2);
fprintf('float a3 = %.15f;\n', a3);
fprintf('float b1 = %.15f;\n', b1);  % Aunque sea 1
fprintf('float b2 = %.15f;\n', b2);
fprintf('float b3 = %.15f;\n', b3);

fprintf('Omega0 = %.4f\n', Omega0);
fprintf('Omegab = %.4f\n\n', Omegab);