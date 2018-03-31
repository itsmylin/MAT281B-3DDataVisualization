void drawMainFrame(){
  if(showFrame){
    int index;
    float degree = PI/5;
    //draw bottom meshes
    for (int i=0; i<deweyData.size(); i++) {
      for(int j=0; j < deweyData.get(i).size()-1; j++){
        if ( (j+1) %12 == 0){
          continue;
        }
        index = j /12;
        pushMatrix();
        translate((float)(centerRadius*Math.cos(index* degree)), 0, (float)(centerRadius*Math.sin(index*degree)));
        rotateY(PI/2-index*degree);
        float x1_1 = pointsOne.get(i).get(j).x;
        float y1_1 = pointsOne.get(i).get(j).y;
        float z1_1 = pointsOne.get(i).get(j).z;
        
        float x2_1 = pointsTwo.get(i).get(j).x;
        float y2_1 = pointsTwo.get(i).get(j).y;
        float z2_1 = pointsTwo.get(i).get(j).z;
        
        float x1_2 = pointsOne.get(i).get(j+1).x;
        float y1_2 = pointsOne.get(i).get(j+1).y;
        float z1_2 = pointsOne.get(i).get(j+1).z;
        
        float x2_2 = pointsTwo.get(i).get(j+1).x;
        float y2_2 = pointsTwo.get(i).get(j+1).y;
        float z2_2 = pointsTwo.get(i).get(j+1).z;
        
        int lineColor = deweyData.get(i).get(j).deweyNumber;
        beginShape();  
        noStroke();
        fill(map(lineColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
        vertex(x1_1, y1_1, z1_1);
        vertex(x2_1, y2_1, z2_1);
        vertex(x2_2, y2_2, z2_2);
        vertex(x1_2, y1_2, z1_2);
        endShape();  
        popMatrix();
      }
   }  

  
    //draw top meshes
    for (int i=0; i<deweyData.size(); i++) {
      for(int j=0; j < deweyData.get(i).size()-1; j++){
        if ( (j+1) %12 == 0){
          continue;
        }
        index = j /12;
        pushMatrix();
        translate((float)(centerRadius*Math.cos(index* degree)), 0, (float)(centerRadius*Math.sin(index*degree)));
        rotateY(PI/2-index*degree);
        float x1_1 = pointsOne.get(i).get(j).x;
        float y1_1 = pointsOne.get(i).get(j).y;
        float z1_1 = pointsOne.get(i).get(j).z;
        
        float x2_1 = pointsThree.get(i).get(j).x;
        float y2_1 = pointsThree.get(i).get(j).y;
        float z2_1 = pointsThree.get(i).get(j).z;
        
        float x1_2 = pointsOne.get(i).get(j+1).x;
        float y1_2 = pointsOne.get(i).get(j+1).y;
        float z1_2 = pointsOne.get(i).get(j+1).z;
        
        float x2_2 = pointsThree.get(i).get(j+1).x;
        float y2_2 = pointsThree.get(i).get(j+1).y;
        float z2_2 = pointsThree.get(i).get(j+1).z;
        
        int lineColor = deweyData.get(i).get(j).deweyNumber;
        beginShape();  
        noStroke();
        fill(map(lineColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
        vertex(x1_1, y1_1, z1_1);
        vertex(x2_1, y2_1, z2_1);
        vertex(x2_2, y2_2, z2_2);
        vertex(x1_2, y1_2, z1_2);
        endShape();      
        popMatrix();
      }
    }  
  
    
    //draw outter meshes
    for (int i=0; i<deweyData.size(); i++) {
      for(int j=0; j < deweyData.get(i).size()-1; j++){
        if ( (j+1) %12 == 0){
          continue;
        }
        index = j /12;
        pushMatrix();
        translate((float)(centerRadius*Math.cos(index* degree)), 0, (float)(centerRadius*Math.sin(index*degree)));
        rotateY(PI/2-index*degree);

        float x1_1 = pointsTwo.get(i).get(j).x;
        float y1_1 = pointsTwo.get(i).get(j).y;
        float z1_1 = pointsTwo.get(i).get(j).z;
        
        float x2_1 = pointsThree.get(i).get(j).x;
        float y2_1 = pointsThree.get(i).get(j).y;
        float z2_1 = pointsThree.get(i).get(j).z;
        
        float x1_2 = pointsTwo.get(i).get(j+1).x;
        float y1_2 = pointsTwo.get(i).get(j+1).y;
        float z1_2 = pointsTwo.get(i).get(j+1).z;
        
        float x2_2 = pointsThree.get(i).get(j+1).x;
        float y2_2 = pointsThree.get(i).get(j+1).y;
        float z2_2 = pointsThree.get(i).get(j+1).z;
        
        int lineColor = deweyData.get(i).get(j).deweyNumber;
        beginShape();  
        noStroke();
        fill(map(lineColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
        vertex(x1_1, y1_1, z1_1);
        vertex(x2_1, y2_1, z2_1);
        vertex(x2_2, y2_2, z2_2);
        vertex(x1_2, y1_2, z1_2);
        endShape();
        popMatrix(); 
      }
    }  
   //draw data layer
    for (int i=0; i<deweyData.size(); i++) {
      for(int j=0; j < deweyData.get(i).size(); j++){
          index = j / 12;
          int distance = (13-int(deweyData.get(i).get(j).month)) * LAYER_DIST;
          pushMatrix();
          translate((float)((distance+centerRadius)*Math.cos(index*degree)), 0, (float)((distance+centerRadius)*Math.sin(index*degree)));
          rotateY(PI/2-index*degree);
          deweyData.get(i).get(j).draw();
          popMatrix();
      }
    }
  }
}

void drawMonthsLabel(){
  if(showFrame){
    pushMatrix();
    translate(0,0,0);
    if(!stopMonth){
      record = -frameCount * 0.002;
    }
    rotateY(record);
    textFont(createFont("Helvetica",34));
    textAlign(CENTER);
    fill(#278ab2);
    for(int i = 0; i < months.length; i++){
      int distance = (12-i)* LAYER_DIST;
      text(months[i],i * 10,0,(float)(distance+centerRadius+5));
    }
    popMatrix();
  }
}

void drawYearsLabel(){
  if(showFrame) {
    int distance = LAYER_DIST * 12;
    float degree = PI/5;
    for (int i = startYear; i <= endYear; i++){
      pushMatrix();
      translate((float)((distance+centerRadius)*Math.cos((i%2007)*degree)), 0, (float)((distance+centerRadius)*Math.sin((i % 2007)*degree)));
      rotateY(PI/2-(i%2007)*degree);
      textAlign(CENTER);
      textSize(25);
      fill(#278ab2);
      text(String.valueOf(i),0,50);
      popMatrix();
    }
  }
}

void drawCenterCircle(){
  pushMatrix();
  translate(0,0);
  rotateX(PI/2);
  stroke(255);
  strokeWeight(3);
  noFill();
  ellipse(0,0,800,800);
  float lastAngle = 0;
  for (int i = 0; i < 10;i++) {
    fill(map(i*100, 0, 990, 0, 255), 255/2, 255, TRANS*2);
    arc(0, 0, centerRadius*2, centerRadius*2, lastAngle, lastAngle+radians(180/5));
    lastAngle += radians(180/5);
  }
  popMatrix();
}

void drawTop(int index,int count, int direction){
   pushMatrix();
   translate(0,map(-1*direction * sqrt(count),0,sqrt(250000),0,1200),0);
   rotateX(PI/2);
   float angle = radians(36 * index);
   fill(map(index*100, 0, 900, 0, 255), 255/2, 255, TRANS*2);
   arc(0, 0, centerRadius*2, centerRadius*2, angle, angle+radians(180/5));
   popMatrix();
}

void drawCylinderBars(int index, int count, int direction){
    float angle = 360 / 90;
    float barHeight = map(sqrt(count),0,sqrt(250000),0,1200);
    fill(map(index*100, 0, 900, 0, 255), 255/2, 255, TRANS*2);
    noStroke();
    pushMatrix();
    translate(0,0);
    rotateX(PI/2);    
    beginShape();  
    noStroke();
    vertex(0, 0, 0);
    vertex(cos( radians( index*9 * angle ) ) * centerRadius,sin( radians( index*9 * angle ) ) * centerRadius,0);
    vertex(cos( radians( index*9* angle ) ) * centerRadius, sin( radians( index*9 * angle ) ) * centerRadius, direction * barHeight);
    vertex(0, 0, direction * barHeight);
    endShape();  
    

    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = index*9; i < (index+1)*9 + 1; i++) {
        float x = cos( radians( i * angle ) ) * centerRadius;
        float y = sin( radians( i * angle ) ) * centerRadius;
        vertex( x, y, 0);
        vertex( x, y, direction * barHeight);    
    }
    endShape(CLOSE);
    
    beginShape();  
    noStroke();
    vertex(0, 0, 0);
    vertex(cos( radians( (index+1)*9 * angle ) ) * centerRadius,sin( radians( (index+1)*9 * angle ) ) * centerRadius,0);
    vertex(cos( radians( (index+1)*9* angle ) ) * centerRadius, sin( radians( (index+1)*9 * angle ) ) * centerRadius, direction * barHeight);
    vertex(0, 0, direction * barHeight);
    endShape();  
    popMatrix();
}

void keyPressed(){
  if (key == ' '){
    boolean focus = cp5.get(Textfield.class,"date1").isFocus();
    cp5.get(Textfield.class,"date1").setFocus(!focus);
    cp5.get(Textfield.class,"date2").setFocus(focus);
  } 
  if (key == ENTER){
    int date1 = parseInput(cp5.get(Textfield.class,"date1").getText());
    int date2 = parseInput(cp5.get(Textfield.class,"date2").getText());
    drawBars[0] = date1;
    drawBars[1] = date2;
  }
  if(key == 's'){
    showFrame = !showFrame;
  }
  if(key == 'z'){
    stopMonth = !stopMonth;
  }
  if(key == 'q'){
    cam.setRotations(0,-(PI/5*camIndex+PI/10),0);
    camIndex += 1;
    camIndex %= 10;
  }
}

int parseInput(String theText) {
  // automatically receives results from controller input
  theText = theText.trim();
  println("a textfield event for controller 'input' : "+theText);
  if(theText == "" || theText.length() == 0){
    return -1;
  }
  String[] date = theText.split("/");
  if (date.length != 2 || int(date[0])>2016 || int(date[0]) < 2007 || int(date[1]) > 12 || int(date[1]) < 0){
    showErrorMsg = true;
    return -1;
  }
  showErrorMsg = false;
  int drawNumber = (int(date[0])-2007) * 12 + (int(date[1])) -1;
  return drawNumber;
}