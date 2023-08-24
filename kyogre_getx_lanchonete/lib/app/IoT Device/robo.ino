const int ledPin1 = 2;
const int ledPin2 = 3;
const int ledPin3 = 4;
const int buzzerPin = 5;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  pinMode(ledPin3, OUTPUT);
  pinMode(buzzerPin, OUTPUT);
}

void loop() {
  if (Serial.available()) {
    char command = Serial.read();
    if (command == 'P') {  // Comando 'P' para novo pedido
      // Acender LEDs em sequência
      digitalWrite(ledPin1, HIGH);
      delay(500);
      digitalWrite(ledPin1, LOW);

      digitalWrite(ledPin2, HIGH);
      delay(500);
      digitalWrite(ledPin2, LOW);

      digitalWrite(ledPin3, HIGH);
      delay(500);
      digitalWrite(ledPin3, LOW);

      // Tocar buzzer sonoro
      tone(buzzerPin, 1000, 500);  // 1000 Hz por 500 ms
      delay(500);
      noTone(buzzerPin);
    }
  }
}
