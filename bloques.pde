Bloque[] y1Bloque = new Bloque[4];
Bloque[] y2Bloque = new Bloque[4];
Bloque[] y3Bloque = new Bloque[4];

void setup() {
  size (500, 500);
  background(200);
  
    for (int i=0; i< y1Bloque.length; i++) {
    y1Bloque[i]= new Bloque(i*125+60,20,1);
  }
  
      for (int h=0; h< y2Bloque.length; h++) {
    y2Bloque[h]= new Bloque(h*125+60,50,1);
  }
  
      for (int m=y3Bloque.length/8; m< y3Bloque.length; m++) {
    y3Bloque[m]= new Bloque(m*125+60,80,1);
  }

  }

void draw() {
  background(200);
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
