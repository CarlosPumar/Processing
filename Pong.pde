/*Proyecto realizado por Carlos Pumar Jiménez, alumno del IES Vicente Aleixandre en la asignatura Prgramación y Computación. Entregado el día 31/01/2017*/

//audio
import ddf.minim.*;
Minim cadena;
AudioPlayer cancion;
AudioPlayer cancionTriste;
AudioPlayer juegoCompletado;

//Variables para el tiempo
long previousMillis;       
long interval = 1000;           
long currentMillis;
int tiempo;
int limiteTiempo=45;

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

//Variable para el rectangulo de informacion en Juego
int rectInfoHeight;

//Vida
int vida=3;
int colorVida1=255;
int colorVida2=255;
int colorVida3=255;

int puntuacion; //Variable para la puntuacion del juego

int pantalla; //Variable para cambio de pantalla

//Variables para el contador
int cont; 
int numeroContador;

//Variables para los colores
int contador_color;
float colorBotones=200;
int estado_colorPerdido;
int pausaColor;
float creditosColor;
float colorExit;

//simbolo retry
int diametroRetry=50;
float colorRetry;

//simbolo home
int ladoHome=40;
float colorHome; 

//simbolo volumen
int colorVolumen;
int volumen=1;

//Variables para los bloque
int separacionBloque=50;
int numBloques=6; //numero de bloques por fila
int nivelbloque=1;

Bloque[] y1Bloque = new Bloque[numBloques];
Bloque[] y2Bloque = new Bloque[numBloques];
Bloque[] y3Bloque = new Bloque[numBloques];

void setup() {
  frameRate(60);
  size(700, 600);
  rectInfoHeight=height/20;
  rectMode(CENTER);
  declaracionVariables();
  nivelbloque=1;

  cadena = new Minim(this);
  cancion= cadena.loadFile("juego.mp3");
  cadena = new Minim(this);
  cancionTriste = cadena.loadFile("cancionTriste.mp3");
  cadena = new Minim(this);
  juegoCompletado = cadena.loadFile("juegoCompletado.mp3");
}


void draw() {
  println(cont);

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
    juego2();
    break;

  case 4:
    pausa();
    break;

  case 5:
    lose();
    break;

  case 6:
    win();
    break;
  }
}


void declaracionVariables() {
  strokeWeight(1);
  stroke(0);
  pausaColor=0;
  tiempo=0;
  vida=3;
  colorVida1=255;
  colorVida2=255;
  colorVida3=255;
  puntuacion=0;
  numeroContador=3;
  cont=0;
  posXball=2*radio;
  posYball=height/10+rectInfoHeight+2.5*separacionBloque;
  velX=5;
  velY=5;
  velXmax=inicioVelXmax;
  velYmin=inicioVelYmin;
  velYmax=sqrt(sq(velXmax)+sq(velYmin));
}



//MENU
void menu() {

  strokeWeight(1);
  textAlign(CENTER);
  textSize(50);
  fill(mouseX*255/width, mouseY*255/height, (mouseY+mouseX)*255/(height+width));
  text("PING PONG", width/2, height*1/3);

  // boton Play
  rectMode(CENTER);
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
    if (nivelbloque==1) {
      pantalla=2;
    } else {
      pantalla=3;
    }
  }
}
void contadorNumero() { //Animacion de cada numero del contador

  if (numeroContador>0) {
    textSize(height/7);
    textAlign(CENTER);
    background(200);
    fill(contador_color);
    text(numeroContador, width/2, height/2);
  }

  contador_color=contador_color+3;
  if (contador_color>=200) {
    background(200);
    contador_color=0;
    numeroContador--;
    cont++;
  }
}



//JUEGO
void juego() {

  //Temporizador
  currentMillis = millis();
  temporizador();
  limiteTiempo=45;
  if (volumen==1) {
    cancion.play();  //tocar cancion
  } else cancion.pause();

  //posicion de la pelota
  posXball=posXball+velX;
  posYball=posYball+velY;

  //posicion de la paleta
  posXpaleta=mouseX;
  posYpaleta=height*9/10;

  dibujarElementos();

  difPos=posXball-mouseX;

  //ReboteX
  if (posXball>=width-radio || posXball<=radio) {
    velX=velX*(-1);
  }
  //ReboteY
  if (posYball<=radio+rectInfoHeight) {
    velY=velY*(-1);
  }
  //Rebote con la paleta
  if ( difPos<=anchuraPaleta/2+radio && difPos>=-(anchuraPaleta/2+radio) && posYball>=height*9/10-radio && posYball<=height*9/10+radio) { 
    rebotePaleta();
  }
  //Restar vida
  if (posYball>=height-radio) {
    vida--;
    if (vida>0) {
      posXball=radio;
      posYball=height/10+rectInfoHeight+2.5*separacionBloque;
      velX=velYmax*sqrt(0.5);
      velY=velYmax*sqrt(0.5);
    }
  }
  if (puntuacion==numBloques*3 && pantalla==2) {  //Win
    declaracionVariables();
    pantalla=1;
    nivelbloque=2;
  }
}

//JUEGO 2
void juego2() {

  //Temporizador
  currentMillis = millis();
  temporizador();
  limiteTiempo=60;

  if (volumen==1) {
    cancion.play();  //tocar cancion
  } else cancion.pause();

  //posicion de la pelota
  posXball=posXball+velX;
  posYball=posYball+velY;

  //posicion de la paleta
  posXpaleta=mouseX;
  posYpaleta=height*9/10;

  dibujarElementos();

  difPos=posXball-mouseX;

  //ReboteX
  if (posXball>=width-radio || posXball<=radio) {
    velX=velX*(-1);
  }
  //ReboteY
  if (posYball<=radio+rectInfoHeight) {
    velY=velY*(-1);
  }
  //Rebote con la paleta
  if ( difPos<=anchuraPaleta/2+radio && difPos>=-(anchuraPaleta/2+radio) && posYball>=height*9/10-radio && posYball<=height*9/10+radio) { 
    rebotePaleta();
  }
  //Restar vida
  if (posYball>=height-radio) {
    vida--;
    if (vida>0) {
      posXball=radio;
      posYball=height/10+rectInfoHeight+2.5*separacionBloque;
      velX=velYmax*sqrt(0.5);
      velY=velYmax*sqrt(0.5);
    }
  }
  if (puntuacion==numBloques*3 && pantalla==3) {  //Win
    nivelbloque=1;
    declaracionVariables();
    pantalla=6;
  }
}

void dibujarElementos() {   //dibuja background, rectangulo de informacion, puntuacion, vida, temporizador, bloques, pelota y paleta

  stroke(0);
  strokeWeight(1);
  background(200-pausaColor); 

  //rect info
  fill(170-pausaColor);
  rectMode(CORNER);
  rect(0, 0, width, rectInfoHeight);
  rectMode(CENTER);

  //Score
  fill(255-pausaColor);
  textAlign(CORNER);
  textSize(25);
  text("SCORE: " + puntuacion, width*7/10, rectInfoHeight*5/6);

  //Temporizador
  if (tiempo<limiteTiempo-5) {
    fill(255-pausaColor);
  } else   fill(255-pausaColor, 0, 0);
  textAlign(CORNER);
  textSize(25);
  text("TIEMPO: " + tiempo, width*3/10, rectInfoHeight*5/6);

  //Pelotas Vida
  colorVida();
  fill(colorVida1, 0, 0);
  ellipse(width/20, rectInfoHeight/2, radio, radio);
  fill(colorVida2, 0, 0);
  ellipse(width/20*2, rectInfoHeight/2, radio, radio);
  fill(colorVida3, 0, 0);
  ellipse(width/20*3, rectInfoHeight/2, radio, radio);

  //Pelota y paleta
  fill(posXball*255/width-pausaColor);
  ellipse(posXball, posYball, radio*2, radio*2);
  rect(posXpaleta, posYpaleta, anchuraPaleta, alturaPaleta);

  dibujarBloque();
}

void temporizador() {
  if  (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    tiempo++;
  }
}

void colorVida() {

  if (vida==2) {
    colorVida3=100;
  }
  if (vida==1) {
    colorVida2=100;
  } 
  if (vida==0 || tiempo==limiteTiempo) {  //Perder
    pantalla=5;
  }
}

void rebotePaleta() {   //rebote de paleta en funcion de difPos

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



//PAUSA
void pausa() {
  pausaColor=50;
  dibujarElementos();
  cancion.pause();

  botonesPause();

  textAlign(CENTER);
  textSize(50);
  fill(255, 0, 0);
  text("PAUSE", width/2, height/2);
}


//LOSE
void lose() {   //Pantalla de LOSE y animacion para volver a intentar

  nivelbloque=1;
  background(200);
  textSize(50);
  fill(30, 30, (mouseX+mouseY)*100/(width+height)+100);
  textAlign(CENTER);
  text("YOU LOSE", width/2, height/2-50);

  cancion.pause();
  cancion.rewind();
  cancionTriste.play();

  botonesFinal();
}



//WIN
void win() {   //Pantalla de WIN y animacion de botones Home y Exit

  nivelbloque=1;
  background(200);
  textSize(50);
  fill((mouseX+mouseY)*100/(width+height)+100, (mouseX+mouseY)*100/(width+height)+100, 40);
  textAlign(CENTER);
  text("YOU WIN", width/2, height/2-150);

  cancion.pause();
  cancion.rewind();
  juegoCompletado.play();

  botonesFinal();

  fill(colorBotones);
  textSize(30);
  text("made by Carlos Pumar", width/2, height/2-50);
}

void botonesFinal() {  //botones Home, Retry y Exit dependiendo de la pantalla

  //Animacion de todos los botones
  fill(colorBotones);

  colorBotones=colorBotones-1.5;
  colorRetry=colorBotones;
  colorHome=colorBotones;
  colorExit=colorBotones;

  if (colorBotones<0 ) { 
    colorBotones=0;

    //Si raton esta encima del boton Home, cambia a color blanco
    if (mouseX>width*2/3-ladoHome/2 && mouseX<width*2/3+ladoHome/2 && mouseY>height*3/4-ladoHome && mouseY<height*3/4+ladoHome/2) {
      colorHome=255;
    }
    //Si raton esta encima del boton Retry, cambia a color blanco
    if (mouseX>width*1/3-diametroRetry/2 && mouseX<width*1/3+diametroRetry/2 && mouseY>height*3/4-diametroRetry && mouseY<height*3/4+diametroRetry/2) {
      colorRetry=255;
    }
    //Si raton esta encima del boton Exit, cambia a color blanco
    if (mouseX>width*1/3-50 && mouseX<width*1/3+50 && mouseY>height*3/4-25 && mouseY<height*3/4+25) {
      colorExit=255;
    }
  }

  //Home siempre se dibuja
  home();

  //Retry y Extit se dibujan dependiendo de la pantalla
  if (pantalla==4) {
    retry();
  } else {
    salir();
  }
}

void botonesPause() {
  if (mouseX>width*2/3-ladoHome/2 && mouseX<width*2/3+ladoHome/2 && mouseY>height*3/4-ladoHome && mouseY<height*3/4+ladoHome/2) {
    colorHome=255;
  } else {
    colorHome=0;
  }
  home();

  if (mouseX>width*1/3-50 && mouseX<width*1/3+20 && mouseY>height*31/40-60 && mouseY<height*31/40+20) {
    colorVolumen=255;
  } else {
    colorVolumen=0;
  }
  volumen();
}

void retry() {   //simbolo retry
  noFill();
  strokeWeight(12);
  stroke(colorRetry);
  arc(width*1/3, height*3/4, diametroRetry, diametroRetry, 0, PI*3/2);
  fill(colorRetry);
  triangle(width*1/3, height*3/4-diametroRetry/4, width*1/3, height*3/4-(diametroRetry*3)/4, width*1/3+diametroRetry/3, height*3/4-diametroRetry/2);
}

void home() {  //simbolo home
  strokeWeight(1);
  noStroke();
  fill(colorHome);
  rect(width*2/3, height*3/4, ladoHome, ladoHome);
  triangle(width*2/3-ladoHome/2-10, height*3/4-ladoHome/2, width*2/3+ladoHome/2+10, height*3/4-ladoHome/2, width*2/3, height*3/4-ladoHome-5);
}

void salir() {  //simbolo exit
  fill(colorExit);
  textSize(50);
  text("EXIT", width*1/3, height*31/40);
}

void volumen() {
  fill(colorVolumen);
  noStroke();
  rectMode(CORNER);
  rect(width*1/3-50, height*31/40-30, 20, 20);
  quad(width*1/3-30, height*31/40-30, width*1/3+20, height*31/40-60, width*1/3+20, height*31/40+20, width*1/3-30, height*31/40-10);

  if (volumen == 0) {
    strokeWeight(10);
    stroke(colorVolumen);
    line( width*1/3+30, height*31/40+30, width*1/3-40, height*31/40-70);
  }
}


//BOTONES Y TECLAS
void keyPressed() {  

  //pausa
  if (key=='p' ) {
    if (pantalla==2 || pantalla==3) {
      pantalla=4;
    } else if (pantalla==4 && nivelbloque==2) {
      pantalla=4;  
      pausaColor=0;
    } else if (pantalla==4 && nivelbloque==1) {
      pantalla=3;  
      pausaColor=0;
    }
  }
}
void mouseClicked() {  
  if (pantalla==0 && mouseX<width/2+75 && mouseX>width/2-75 && mouseY<height*2/3+30 && mouseY>height*2/3-30) {   //Pulsar Play en el menu
    pantalla=1;
  }
  if (colorHome==255 && (pantalla==4 || pantalla==5 || pantalla==6)) {   //Pulsar boton Home
    background(200);
    colorBotones=200;
    declaracionVariables();
    cancion.pause();
    cancion.rewind();
    cancionTriste.pause();
    cancionTriste.rewind();
    juegoCompletado.pause();
    juegoCompletado.rewind();
    pantalla=0;
  }
  if (colorRetry==255 && pantalla==5) {  //Pulsar boton Retry
    background(200);
    colorBotones=200;
    declaracionVariables();
    cancionTriste.pause();
    cancionTriste.rewind();
    pantalla=1;
  }
  if (colorExit==255 && pantalla==6) {  //Pulsar boton Exit
    exit();
  }
  if (colorVolumen==255 && pantalla==4) {  //Pulsar boton Volumen
    if (volumen==1) {
      volumen=0;
    } else volumen=1;
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
    if (z == 2) {
      fill(0, 0, 55+posXball*200/width-pausaColor);
    } else {
      fill(posXball*255/width-pausaColor);
    }
    if (z==1 || z==2) {
      rect(x, y, anchura, altura);
    }
  }
  void desaparecer() {
    if (posXball>x-anchura/2-radio && posXball<x+anchura/2+radio && posYball>y-altura/2-radio && posYball<y+altura/2+radio) {
      if (z==1) {
        z=0;
        velY= velY*(-1);
        puntuacion++;
      } else if (z==2) {
        z=1;
        velY= velY*(-1);
      }
    }
  }
}
void crearBloque() {
  for (int i=0; i< y1Bloque.length; i++) {
    y1Bloque[i]= new Bloque(i*width/numBloques+width/(2*numBloques), height/10+rectInfoHeight, nivelbloque);
  }
  for (int h=0; h< y2Bloque.length; h++) {
    y2Bloque[h]= new Bloque(h*width/numBloques+width/(2*numBloques), height/10+rectInfoHeight+separacionBloque, nivelbloque);
  }  
  for (int m=y3Bloque.length/8; m< y3Bloque.length; m++) {
    y3Bloque[m]= new Bloque(m*width/numBloques+width/(2*numBloques), height/10+rectInfoHeight+2*separacionBloque, nivelbloque);
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
