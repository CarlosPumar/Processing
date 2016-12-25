/*Proyecto realizado por Carlos Pumar Jiménez,alumno del IES Vicente Aleixandre*/

//Variables de la bola
float posXball;
float posYball;
int radio=12;

//Variables para la velocidad de la pelota
float velX=2;
float velY=2;
float inicioVelXmax=5;
float inicioVelYmin=5;
float velXmax;
float velYmax;
float velYmin;
float aumentoVelocidad=0.2;
float difPos;

//Variables para la paleta
int anchuraPaleta=75;
int alturaPaleta=5;
float posXpaleta;
float posYpaleta;

int pantalla; //Variable para cambio de pantalla

//Variable para el contador
int cont; 
int numeroContador;

//Variables para los colores
int colorContador;
float colorPerdido=200;

Bloque[] y1Bloque = new Bloque[4];
Bloque[] y2Bloque = new Bloque[4];
Bloque[] y3Bloque = new Bloque[4];

void setup() {
  size(500, 500);
  rectMode(CENTER);
  declaracionVariables();
}


void draw() {

  switch(pantalla) {
  case 0:
    menu();
    break;

  case 1:
    contador();
    break;

  case 2:
    juego();
    break;

  case 3:
    pausa();
    break;

  case 4:
    lose();
    break;
  }
}


void declaracionVariables() {
  numeroContador=3;
  cont=0;
  posXball=radio;
  posYball=100;
  velX=5;
  velY=5;
  velXmax=inicioVelXmax;
  velYmin=inicioVelYmin;
  velYmax=sqrt(sq(velXmax)+sq(velYmin));
}


//MENU
void menu() {
  background(200);
  textSize(50);
  fill(0);
  textAlign(CENTER);
  text("PING PONG", width/2, height*1/3);

  // boton Play
  if (mouseX<width/2+75 && mouseX>width/2-75 && mouseY<height*2/3+30 && mouseY>height*2/3-30) {
    fill(0);
    rect(width/2, height*2/3, 150, 60);
    fill(255);
    text("PLAY", width/2, height*2/3+20);
  } else {
    fill(255);
    rect(width/2, height*2/3, 150, 60);
    fill(0);
    text("PLAY", width/2, height*2/3+20);
  }
}



//CONTADOR
void contador() {  //Contador al principio de partidas

  if (cont == 0) {
    contadorNumero();
  }
  if (cont == 1) {
    contadorNumero();
  }
  if (cont == 2) {
    contadorNumero();
  }
  if (cont == 3) {
    contadorNumero();
    crearBloque();
    pantalla=2;
  }
}

void contadorNumero() { //Animacion de cada numero del contador

  if (numeroContador>0) {
    textSize(50);
    textAlign(CENTER);
    background(200);
    fill(colorContador);
    text(numeroContador, width/2, height/2);
  }

  colorContador=colorContador+2;
  if (colorContador>=200) {
    background(200);
    colorContador=0;
    numeroContador--;
    cont++;
  }
}



//JUEGO
void juego() {

  background(200);
  fill(posXball*255/width);
  posXball=posXball+velX;
  posYball=posYball+velY;
  ellipse(posXball, posYball, radio*2, radio*2);
  rect(mouseX, height*9/10, anchuraPaleta, alturaPaleta);
  dibujarBloque();
  difPos=posXball-mouseX;

  //ReboteX
  if (posXball>=width-radio || posXball<=radio) {
    velX=velX*(-1);
  }
  //ReboteY
  if (posYball<=radio) {
    velY=velY*(-1);
  }
  //Rebote con la paleta
  if ( difPos<=anchuraPaleta/2+radio && difPos>=-(anchuraPaleta/2+radio) && posYball>=height*9/10-radio) { 
    rebotePaleta();
  }
  //Perder
  if (posYball>=height-radio) {
    pantalla=3;
  }
}

void rebotePaleta() {

  velXmax=velXmax+aumentoVelocidad;
  velYmin=velYmin+aumentoVelocidad;
  velYmax=sqrt(sq(velXmax)+sq(velYmin));

  velX= difPos*velXmax/(anchuraPaleta/2+radio);
  if (difPos <0) {
    velY= -(-difPos*(velYmin-velYmax)/(anchuraPaleta/2+radio)+velYmax);
  } else {
    velY= -(difPos*(velYmin-velYmax)/(anchuraPaleta/2+radio)+velYmax);
  }
}

class Bloque {

  int x, y, z, anchura, altura;

  Bloque (int posX, int posY, int estado) {  //constructor
    x=posX;
    y=posY;
    z=estado;
    anchura=50;
    altura=10;
  }
  void dibujar() {
    if (z==1) {
      rect(x, y, anchura, altura);
    }
  }
  void desaparecer() {
    if (posXball>x-anchura/2-radio && posXball<x+anchura/2+radio && posYball>y-altura/2-radio && posYball<y+altura/2+radio && z==1) {
      z=0;
      velY= velY*(-1);
    }
  }
}

void crearBloque() {
  for (int i=0; i< y1Bloque.length; i++) {
    y1Bloque[i]= new Bloque(i*125+60, 20, 1);
  }
  for (int h=0; h< y2Bloque.length; h++) {
    y2Bloque[h]= new Bloque(h*125+60, 50, 1);
  }  
  for (int m=y3Bloque.length/8; m< y3Bloque.length; m++) {
    y3Bloque[m]= new Bloque(m*125+60, 80, 1);
  }
}

void dibujarBloque() {
  for (int i=0; i< y1Bloque.length; i ++) {
    y1Bloque[i].dibujar();
    y1Bloque[i].desaparecer();
  }

  for (int h=0; h< y2Bloque.length; h ++) {
    y2Bloque[h].dibujar();
    y2Bloque[h].desaparecer();
  }

  for (int m=0; m< y2Bloque.length; m ++) {
    y3Bloque[m].dibujar();
    y3Bloque[m].desaparecer();
  }
}



//LOSE
void lose() {   //Pantalla de LOSE y animacion para volver a intentar

  background(200);
  textSize(50);
  fill(0);
  textAlign(CENTER);
  text("YOU LOSE", width/2, height/2);
  fill(colorPerdido);
  colorPerdido=colorPerdido-0.5;

  if (colorPerdido<0) {
    colorPerdido=0;
  }

  textSize(25);
  text("SPACE TO RETRY", width/2, height*2/3);
  text("M TO MENU", width/2, height*2/3+50);
}



//RESTO
void keyPressed() {    //Al perder para reiniciar o para volver al menu

  if (key==32 && pantalla==3) {
    background(200);
    colorPerdido=200;
    declaracionVariables();
    pantalla=1;
  }
  if (key==109 && pantalla==3) {
    background(200);
    colorPerdido=200;
    declaracionVariables();
    pantalla=0;
  }
}

void mouseClicked() {   //Pulsar Play en el menu
  if (pantalla==0 && mouseX<width/2+75 && mouseX>width/2-75 && mouseY<height*2/3+30 && mouseY>height*2/3-30) {
    pantalla=1;
  }
}
