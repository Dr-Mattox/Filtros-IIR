% Parámetros
Fs = 1291.32;             % Frecuencia de muestreo (Hz)
Fc = 200;                 % Frecuencia de corte (Hz)
zeta = sqrt(2)/2;         % Amortiguamiento crítico

% Cálculo de frecuencia análoga
Omega = 2 * Fs * tan(pi * Fc / Fs);

% Coeficientes del filtro (según fórmulas del documento)
a1 = 4*Fs^2 / (4*Fs^2 + 4*zeta*Fs*Omega + Omega^2);
a2 = -2 * a1;
a3 = a1;
b1 = 1;
b2 = (2*Omega^2 - 8*Fs^2) / (4*Fs^2 + 4*zeta*Fs*Omega + Omega^2);
b3 = (4*Fs^2 - 4*zeta*Fs*Omega + Omega^2) / (4*Fs^2 + 4*zeta*Fs*Omega + Omega^2);

% Mostrar coeficientes
fprintf('Coeficientes del filtro pasa altas:\n');
fprintf('float a1 = %.15f;\n', a1);
fprintf('float a2 = %.15f;\n', a2);
fprintf('float a3 = %.15f;\n', a3);
fprintf('float b1 = %.15f;\n', b1);
fprintf('float b2 = %.15f;\n', b2);
fprintf('float b3 = %.15f;\n', b3);
fprintf('Omega = %.15f\n', Omega);

