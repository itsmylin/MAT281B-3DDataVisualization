void GUI(){
  cam.beginHUD();  //Stopping peasy cam
  fill(150);
  rect(0, 0, width, 40);
  fill(255);
  if(showErrorMsg){
    fill(#e52b37);
    textAlign(LEFT);
    textSize(20);
    text(errorMsg,800,25);
  }
  for(int i = 0; i < deweyNames.length; i++){
    fill(map(i*100, 0, 990, 0, 255), 255/2, 255, TRANS*1.5);
    rect(30, 50 + 30*i, 25, 25);
    fill(0);
    textAlign(LEFT);
    textSize(20);
    text(deweyNames[i], 55, 72.5 + 30*i);
  }
  // draw descritpion
  fill(0);
  textSize(20);
  text("*Size = Number of checkout\n*One block = One month",30, 600);
  for(int i = 0; i < 10; i++){
    stroke(50,100);
    fill(map(i*100, 0, 990, 0, 255), 255/2, 255, TRANS*1.5);
    triangle(150, 475, (float)(150+100*Math.cos(i*PI/5)),(float)(475+100*sin(i*PI/5)),
            (float)(150+100*cos((i+1)*PI/5)),(float)(475+100*sin((i+1)*PI/5)));
  }
  cp5.draw();
  cam.endHUD();
}