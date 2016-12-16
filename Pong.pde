float posXball;
float posYball;
float velX=5;
float velY=5;

float inicioVelXmax=5;
float inicioVelYmin=5;

float velXmax;
float velYmax;
float velYmin;
float aumentoVelocidad=0.2;

float difPos;
int anchuraPaleta=100;

int radio=12;

int partida;

int cont;
int colorContador;

float colorPerdido=200;

void setup() {
  size(500, 500);
  posXball=radio;
  posYball=radio;
  velXmax=inicioVelXmax;
  velYmin=inicioVelYmin;
  velYmax=sqrt(sq(velXmax)+sq(velYmin));
}


void draw() {

  contador();

  if (partida ==1) {
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
    if (posYball>=height-radio*2 || posYball<=0) {
      velY=velY*(-1);
    }
    if ( difPos<=anchuraPaleta/2+radio && difPos>=-(anchuraPaleta/2+radio) && posYball>=height*9/10-radio*2) {
      rebotePaleta();
    }
    //Perder
    if (posYball>=height-radio*2) {
      partida=2;
    }
  }  

  if (partida ==2) {
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
}

void contador() {
  textSize(50);
  textAlign(CENTER);
  if (cont==0) {
    fill(colorContador);
    text("3", width/2, height/2);
    colorContador=colorContador+2;
    if (colorContador>=200) {
      background(200);
      colorContador=0;
      cont=1;
    }
  }
  if (cont==1) {
    fill(colorContador);
    text("2", width/2, height/2);
    colorContador=colorContador+2;
    if (colorContador>=200) {
      background(200);
      colorContador=0;
      cont=2;
    }
  }
  if (cont==2) {
    fill(colorContador);
    text("1", width/2, height/2);
    colorContador=colorContador+2;
    if (colorContador>=200) {
      background(200);
      colorContador=0;
      cont=3;
      partida=1;
      velX=5;
      velY=5;
      velXmax=inicioVelXmax;
      velYmin=inicioVelYmin;
      velYmax=sqrt(sq(velXmax)+sq(velYmin));
    }
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

void keyPressed() {
  if (key==32 && partida==2) {
    posXball=radio;
    posYball=radio;
    background(200);
    colorPerdido=200;
    cont=0;
    partida=0;
    contador();
  }
}
