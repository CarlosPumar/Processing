/*Proyecto realizado por Carlos Pumar Jiménez,alumno del IES Vicente Aleixandre*/

//Variables de la bola
float posXball;
float posYball;
int radio=12;

//Variables para la velocidad de la pelota
float velX=5;
float velY=5;
float inicioVelXmax=5;
float inicioVelYmin=5;
float velXmax;
float velYmax;
float velYmin;
float aumentoVelocidad=0.2;
float difPos;

//Variables para la paleta
int anchuraPaleta=100;
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


void setup() {
  size(500, 500);
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
    lose();
    break;
  }
}


void declaracionVariables() {
  numeroContador=3;
  cont=0;
  posXball=radio;
  posYball=radio;
  velX=5;
  velY=5;
  velXmax=inicioVelXmax;
  velYmin=inicioVelYmin;
  velYmax=sqrt(sq(velXmax)+sq(velYmin));
}

void menu() {
  background(200);
  textSize(50);
  fill(0);
  textAlign(CENTER);
  text("PING PONG", width/2, height*1/3);

// boton Play
  if (mouseX<width/2+75 && mouseX>width/2-75 && mouseY<height*2/3+60 && mouseY>height*2/3) {
    fill(0);
    rect(width/2-75, height*2/3, 150, 60);
    fill(255);
    text("PLAY", width/2, height*2/3+47.5);
  } else {
    fill(255);
    rect(width/2-75, height*2/3, 150, 60);
    fill(0);
    text("PLAY", width/2, height*2/3+47.5);
  }

}


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

void juego() {

  background(200);
  fill(posXball*255/width);
  posXball=posXball+velX;
  posYball=posYball+velY;
  ellipse(posXball, posYball, radio*2, radio*2);
  rect(mouseX-anchuraPaleta/2, height*9/10, anchuraPaleta, 5);
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
  if (pantalla==0 && mouseX< width/2+75 && mouseX>width/2-75 && mouseY<height*2/3+60 && mouseY>height*2/3) {
    pantalla=1;
  }
}
