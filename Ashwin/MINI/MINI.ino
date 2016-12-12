int motor1=2;
int motor11=3;
int motor2=4;
int motor22=5;
int led =13;
//int led2=10;
char a;



void setup()
{
 
  Serial.begin(9600);
  pinMode(motor1,OUTPUT);
  pinMode(motor11,OUTPUT);
  pinMode(motor2,OUTPUT);
  pinMode(motor22,OUTPUT);
    pinMode(led,OUTPUT);
    // pinMode(led2,OUTPUT);
  
  Serial.println("robo start");
  delay(1000);
  
}
void loop()
{
if (Serial.available() > 0)
{

}
a=Serial.read();
if(a=='d')
{
   Serial.println("Right");
  digitalWrite(motor1,HIGH);
  digitalWrite(motor11,LOW);
  digitalWrite(motor2,HIGH);
  digitalWrite(motor22,LOW);
  delay(2000);
}
else if(a=='w')
{
Serial.println("forward");
  digitalWrite(motor1,HIGH);
  digitalWrite(motor11,LOW);
  digitalWrite(motor2,LOW);
  digitalWrite(motor22,HIGH);
  delay(2000);
}
else if(a=='x')
{
   Serial.println("stop");
  digitalWrite(motor1,LOW);
  digitalWrite(motor11,LOW);
  digitalWrite(motor2,LOW);
  digitalWrite(motor22,LOW);
  delay(2000);
}
else if(a=='s')
{
  Serial.println("backward");
  digitalWrite(motor1,LOW);
  digitalWrite(motor11,HIGH);
  digitalWrite(motor2,HIGH);
  digitalWrite(motor22,LOW);
  delay(2000);
}

else if(a=='a')
{
   Serial.println("left");
  digitalWrite(motor1,LOW);
  digitalWrite(motor11,HIGH);
  digitalWrite(motor2,LOW);
  digitalWrite(motor22,HIGH);
  delay(2000);
}

else if(a=='h')
{
   Serial.println("LED HIGH");
   digitalWrite(led,HIGH);
  
}



else if(a=='l')
{
   Serial.println("LED LOW");
   digitalWrite(led,LOW);
 
}
}

