clc; clear;

% Especificaciones del filtro
Fc = 200;           % Frecuencia central en Hz
BW = 50;            % Ancho de banda en Hz
Fs = 1291.32/2;       % Frecuencia de muestreo en Hz

% Pre-warping de las frecuencias analógicas
Omega_c = 2 * Fs * tan(pi * Fc / Fs);
Delta_Omega = 2 * Fs * tan(pi * BW / Fs);

% Diseño del filtro analógico prototipo pre-warped
num_s = Delta_Omega * [1, 0];  % Numerador: Delta_Omega * s
den_s = [1, Delta_Omega, Omega_c^2];  % Denominador: s² + ΔΩ·s + Ωc²
Hs = tf(num_s, den_s);

% Transformación bilineal
Ts = 1 / Fs;
Hz = c2d(Hs, Ts, 'tustin');

% Obtener coeficientes b y a
[num_z, den_z] = tfdata(Hz, 'v');
b = num_z;
a = den_z;

% Normalización
a = a / a(1);
b = b / a(1);

% Mostrar como lista para Arduino IDE
fprintf('\n// Coeficientes exportados para Arduino IDE\n');
fprintf('float a1 = %.15f;\n', b(1));
fprintf('float a2 = %.15f;\n', b(2));
fprintf('float a3 = %.15f;\n', b(3));
fprintf('float b1 = %.15f;\n', 1);
fprintf('float b2 = %.15f;\n', a(2));
fprintf('float b3 = %.15f;\n', a(3));