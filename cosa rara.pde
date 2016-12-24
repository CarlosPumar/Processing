int filas=3;
int columnas=4;
int numeroBloques=12;
Bloque[] miBloque = new Bloque[numeroBloques];


void setup() {
  size (500, 500);
  background(200);

    for (int i=0; i<miBloque.length; i++) {
      if (i<=3){
      miBloque[i]= new Bloque(i*125+20, 20, 1);
    }
    if (i<=7 && i>3){
      miBloque[i]= new Bloque((i-4)*125+20, 50, 1);
    }
        if (i<=11 && i>7){
      miBloque[i]= new Bloque((i-8)*125+20, 80, 1);
    }
  }
}
void draw() {
  background(200);
    for (int i=0; i<miBloque.length; i++) {
      miBloque[i].dibujar();
      miBloque[i].desaparecer();
    }
  
}

class Bloque {

  int x, y, z, anchura, altura;

  //CONSTRUCTOR
  Bloque (int posX, int posY, int estado) {
    x=posX;
    y=posY;
    z=estado;
    anchura=75;
    altura=10;
  }
  void dibujar() {
    if (z==1) {
      rectMode(CENTER);
      rect(x, y, anchura, altura);
    }
  }
  void desaparecer() {
    if (mouseX>x) {
      z=0;
    }
  }
}
