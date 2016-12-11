float xPupila;
float yPupila;

int centroX=250;
int centroY=250;

int radio=125;
float H;

void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  //circulo exterior
  ellipse(width/2, height/2, radio*2, radio*2);

  //pupila
  H=(mouseY-centroY)/float(mouseX-centroX);
  if (sqrt(sq(mouseX-centroX)+sq(mouseY-centroY)) < radio) {
    xPupila=mouseX;
    yPupila=mouseY;
    ellipse(xPupila, yPupila, 50, 50);
  } else {
    if (mouseX>=centroX) {
      xPupila=sqrt(sq(radio)/(sq(H)+1));
      yPupila=H*xPupila;
    }
    if (mouseX<=centroX) {
      xPupila=-sqrt(sq(radio)/(sq(H)+1));
      yPupila=H*xPupila;
    }
    ellipse(xPupila+centroX, yPupila+centroY, 50, 50);
  }
}
