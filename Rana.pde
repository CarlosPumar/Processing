float pupilaX1;
float pupilaY1;
float pupilaX2;
float pupilaY2;
float H;
float H2;


void setup() {
  size(500, 250);
}

void draw() {
  //Background
  background(255);
  
  //Cara
  stroke(8, 75, 16);
  strokeWeight(5);
  fill(54, 198, 52);
  ellipse(width/2, height/2, 300, 150);
  //Ojos
  
  fill(255);
  ellipse(width*2/3, 75, 65, 65);
  ellipse(width*1/3, 75, 65, 65);


  //Boca
  stroke(8, 75, 16);
  fill(255, 0, 0);
  ellipse(width/2, 175, 100, 20);


  //Nariz
  ellipse(225, 140, 5, 10);
  ellipse(275, 140, 5, 10);


  //Pupila
  fill(0);
  noStroke();
  
   if (mouseX-333 != 0) {
    H=(mouseY-75)/float(mouseX-333);
  }
     if (mouseX-167 != 0) {
    H2=(mouseY-75)/float(mouseX-167);
  }
  
if (sqrt(sq(mouseX-333)+sq(mouseY-75)) < 25) {
    pupilaX1=mouseX;
    pupilaY1=mouseY;
    fill(0);
    noStroke();
    ellipse(pupilaX1, pupilaY1, 30, 30);
  } else {
    if (mouseX != 0) {
      if (mouseX>=333) {
        pupilaX1=sqrt(625/(sq(H)+1));
        pupilaY1=H*pupilaX1;
      }
      if (mouseX<=333) {
        pupilaX1=-sqrt(625/(sq(H)+1));
        pupilaY1=H*pupilaX1;
      } 


      fill(0);
      noStroke();
      ellipse(pupilaX1+333, pupilaY1+75, 30, 30);
    }
  }
  
//Pupila2
   if (mouseX-167 != 0) {
    H=(mouseY-75)/float(mouseX-167);
  }
  
if (sqrt(sq(mouseX-167)+sq(mouseY-75)) < 25) {
    pupilaX2=mouseX;
    pupilaY2=mouseY;
    fill(0);
    noStroke();
    ellipse(pupilaX2, pupilaY2, 30, 30);
  } else {
    if (mouseX != 0) {
      if (mouseX>=167) {
        pupilaX2=sqrt(625/(sq(H2)+1));
        pupilaY2=H2*pupilaX2;
      }
      if (mouseX<=167) {
        pupilaX2=-sqrt(625/(sq(H2)+1));
        pupilaY2=H2*pupilaX2;
      } 
      fill(0);
      noStroke();
      ellipse(pupilaX2+167, pupilaY2+75, 30, 30);
    }
  }
}
