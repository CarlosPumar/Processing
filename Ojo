float xPupila;
float yPupila;

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
  H=(mouseY-250)/float(mouseX-250);
  if (sqrt(sq(mouseX-250)+sq(mouseY-250)) < radio) {
    xPupila=mouseX;
    yPupila=mouseY;
    ellipse(xPupila, yPupila, 50, 50);
  } else {
    if (mouseX>=250) {
      xPupila=sqrt(sq(radio)/(sq(H)+1));
      yPupila=H*xPupila;
    }
    if (mouseX<=250) {
      xPupila=-sqrt(sq(radio)/(sq(H)+1));
      yPupila=H*xPupila;
    }
    ellipse(xPupila+250, yPupila+250, 50, 50);
  }
}
