/*Proyecto realizado por Carlos Pumar Jiménez,alumno del IES Vicente Aleixandre*/


//Posicion de la bola
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

int cont; //Variable para el contador
int numeroContador;

//Variables para los colores
int colorContador;
float colorPerdido=200;

void setup() {
  size(500, 500);
  declaracionVariables();
}


void draw() {

  background(200);
  switch(pantalla) {
  case 0:
    contador();
    break;

  case 1:
    juego();
    break;

  case 2:
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
    pantalla=1;
  }
  
}


void contadorNumero() { //Animacion de cada numero del contador

  if (numeroContador>0) {
    textSize(50);
    textAlign(CENTER);
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
  rect(posXball, posYball, radio*2, radio*2);
  rect(mouseX-anchuraPaleta/2, height*9/10, anchuraPaleta, 5);
  difPos=posXball-(mouseX-radio);

  //ReboteX
  if (posXball>=width-radio*2 || posXball<=0) {
    velX=velX*(-1);
  }
  //ReboteY
  if (posYball<=0) {
    velY=velY*(-1);
  }
  //Rebote con la paleta
  if ( difPos<=anchuraPaleta/2+radio && difPos>=-(anchuraPaleta/2+radio) && posYball>=height*9/10-radio*2) { 
    rebotePaleta();
  }
  //Perder
  if (posYball>=height-radio*2) {
    pantalla=2;
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
}


void keyPressed() {
  
  if (key==32 && pantalla==2) {
    background(200);
    colorPerdido=200;
    declaracionVariables();
    pantalla=0;
  }
  
}

