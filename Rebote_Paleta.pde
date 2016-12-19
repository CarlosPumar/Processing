//Variables de la bola
float posXball;
float posYball;
int radio=12;

//Variables para la velocidad de la pelota
float velX=5;
float velY=5;

float velXmax;
float velYmax;
float velYmin;

float difPos;

//Variables para la paleta
int anchuraPaleta=100;
int alturaPaleta=5;
float posXpaleta;
float posYpaleta;

void setup() {
  size(500, 500);

  posXball=radio;
  posYball=radio;
  velX=5;
  velY=5;
  velXmax=5;
  velYmin=5;
  velYmax=sqrt(sq(velXmax)+sq(velYmin));
  
}


void draw() {

  background(200);
  fill(0);
  posXball=posXball+velX;
  posYball=posYball+velY;
  ellipse(posXball, posYball, radio*2, radio*2);
  rect(mouseX-anchuraPaleta/2, height*9/10, anchuraPaleta, alturaPaleta);
  difPos=posXball-mouseX;

  //ReboteX
  if (posXball>=width-radio || posXball<=radio) {
    velX=velX*(-1);
  }
  //ReboteY
  if (posYball<=radio || posYball>height-radio) {
    velY=velY*(-1);
  }
  //Rebote con la paleta
  if ( difPos<=anchuraPaleta/2+radio && difPos>=-(anchuraPaleta/2+radio) && posYball>=height*9/10-radio) { 
    rebotePaleta();
  }
}

void rebotePaleta() {

  velYmax=sqrt(sq(velXmax)+sq(velYmin));

  velX= difPos*velXmax/(anchuraPaleta/2+radio);
  if (difPos <0) {
    velY= -(-difPos*(velYmin-velYmax)/(anchuraPaleta/2+radio)+velYmax);
  } else {
    velY= -(difPos*(velYmin-velYmax)/(anchuraPaleta/2+radio)+velYmax);
  }
}
