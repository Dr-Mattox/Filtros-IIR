// ==== Parámetros del filtro IIR Rechaza Bandas ====
float a1 = 0.837567925584333;
float a2 = -0.942607956526630;
float a3 = 0.837567925584333;
float b1 = 1.000000000000000;
float b2 = -0.942607956526630;
float b3 = 0.675135851168666;

float Fs = 1291.32/2;  // Frecuencia de muestreo
float RC = 0;

// Buffers
float x0 = 0, x1 = 0, x2 = 0;
float yf0 = 0, yf1 = 0, yf2 = 0;

// ==== Pines ====
#define SIGNAL_INPUT A0
#define SIGNAL_OUTPUT_RAW DAC0
#define SIGNAL_OUTPUT_FILTERED DAC1

void setup() {
  analogReadResolution(12);    // ADC 12 bits
  analogWriteResolution(12);   // DAC 12 bits
  analogWrite(SIGNAL_OUTPUT_RAW, 0);
  analogWrite(SIGNAL_OUTPUT_FILTERED, 0);

  configureTimerTC3();  // Usa Timer TC3 para interrupciones de muestreo
}

void loop() {
  // Nada aquí
}

void configureTimerTC3() {
  pmc_enable_periph_clk(ID_TC3);  // Habilitar reloj para TC3
  TcChannel *t = &(TC1->TC_CHANNEL[0]);

  t->TC_CCR = TC_CCR_CLKDIS;
  t->TC_IDR = 0xFFFFFFFF;
  t->TC_SR;

  t->TC_RC = (SystemCoreClock / 2) / Fs;
  t->TC_CMR = TC_CMR_TCCLKS_TIMER_CLOCK1 | TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC;
  t->TC_IER = TC_IER_CPCS;
  t->TC_CCR = TC_CCR_CLKEN | TC_CCR_SWTRG;

  NVIC_EnableIRQ(TC3_IRQn);
}

// ==== Interrupción del Timer TC3 ====
void TC3_Handler() {
  TC1->TC_CHANNEL[0].TC_SR;

  float input_signal = analogRead(SIGNAL_INPUT) - 2048.0;

  analogWrite(SIGNAL_OUTPUT_RAW, constrain(input_signal + 2048, 0, 4095));

  // Desplazar buffers
  x2 = x1; x1 = x0; x0 = input_signal;
  yf2 = yf1; yf1 = yf0;

  // Ecuación del filtro
  yf0 = a1 * x0 + a2 * x1 + a3 * x2
       - b2 * yf1 - b3 * yf2;

  // Salida filtrada
  analogWrite(SIGNAL_OUTPUT_FILTERED, constrain(yf0 + 2048, 0, 4095));
}
