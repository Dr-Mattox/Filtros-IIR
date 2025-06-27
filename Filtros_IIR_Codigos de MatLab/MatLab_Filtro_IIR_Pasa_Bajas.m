% Parámetros
Fs = 1291.32;           % Frecuencia de muestreo (Hz)
Fc = 100;               % Frecuencia de corte (Hz)
zeta = (sqrt(2))/2;       % Amortiguamiento

% Cálculo de frecuencia análoga
Omega = 2 * Fs * tan(pi * Fc / Fs);

% Coeficientes del filtro (según fórmula del documento)
a1 = (Omega^2) / (4*(Fs)^2 + 4*zeta*Fs*Omega + Omega^2);
a2 = 2 * a1;
a3 = a1;

b1 = 1;
b2 = (-8*Fs^2 + 2*Omega^2) / (Omega^2 + 4*zeta*Fs*Omega + 4*Fs^2);
b3 = (Omega^2 - 4*zeta*Fs*Omega + 4*Fs^2) / (Omega^2 + 4*zeta*Fs*Omega + 4*Fs^2);
% Mostrar coeficientes
fprintf('Coeficientes del filtro:\n');
fprintf('float a1 = %.15f;\n', a1);
fprintf('float a2 = %.15f;\n', a2);
fprintf('float a3 = %.15f;\n', a3);
fprintf('float b2 = %.15f;\n', b2);
fprintf('float b3 = %.15f;\n', b3);
fprintf('Omega = %.15f\n', Omega);

% Simulación de señal
N = 1000;                        % Número de muestras
t = (0:N-1)/Fs;                  % Vector de tiempo
x = sin(2*pi*50*t);             % Señal de entrada (ej. 50 Hz seno)

% Inicialización
y = zeros(1, N);
x_prev = zeros(1, 3);
y_prev = zeros(1, 3);

% Aplicar filtro IIR
for n = 3:N
    x_prev = x(n:-1:n-2);
    y_prev = y(n-1:-1:n-2);
    y(n) = a1*x_prev(1) + a2*x_prev(2) + a3*x_prev(3) ...
         + b1*y_prev(1) + b2*y_prev(2);
end

