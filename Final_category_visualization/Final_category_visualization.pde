/*************************************************************************************
 Data Visualization - Final Project              
 Processing 3                                    
 
 Author: Ming-Yu Lin                      
 
 Finished on March 10th, 2018
 
 Purpose: Display the number of times of checkout from ten dewey categories from 2007 to 2016
          Compare the number of times of checkout for single month
          Compare the number of times of checkout for two months
 
 Usage: 1. Press SPACE and enter the specific month in YYYY/MM format to see more clear data.
        2. Press SPACE again to enter the second month that is going to compare in YYYY/MM format.
        3. Press 's' to show or hide the main data framework.
        4. Press 'q' to switch camera position for each year.
        5. Press 'z' to stop the months label.
 
 Required Libraries:
 1. Peasy Cam -> Accessible from Processing Import Library 
 2. Control P5 -> Accessible from Processing Import Library
 
 A few codes adopted reference code from Rodger Luo's TreeMap Demo.
 *************************************************************************************/


import peasy.*;
import controlP5.*; //GUI library

PeasyCam cam;
ControlP5 cp5; //User Interface 

int startYear = 2007;
int endYear = 2016;
int centerRadius = 400;
float record;
int camIndex = 0;
int[] drawBars = new int[] {-1 ,-1};
Table table;
Table deweyTable;
int numRows, numColumns;
ArrayList<Category> categories = new ArrayList<Category>();
ArrayList<ArrayList<Category>> deweyData;
HashMap<Integer, String> deweyMap;
String[] deweyNames;
String[] months = new String[] {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
String errorMsg = "Wrong date format! Please enter in YYYY/MM format";
//Setting

final int NUM_LAYERS = 12;   //Number of Layers;
                             
final int LAYER_DIST = 70;  //Distance between each layer in virtual space 

final int TRANS = 100; // Transparacny of layers

//Variables for drawing rects
ArrayList<ArrayList<PVector>> pointsOne = new ArrayList<ArrayList<PVector>>();
ArrayList<ArrayList<PVector>> pointsTwo = new ArrayList<ArrayList<PVector>>();
ArrayList<ArrayList<PVector>> pointsThree = new ArrayList<ArrayList<PVector>>();

boolean showFrame;
boolean stopMonth;
boolean showErrorMsg;
PFont myHelvetica;

void setup(){
  
  size(1980, 1440, P3D);
  cam = new PeasyCam(this, 1400);
  cp5 = new ControlP5(this);
  myHelvetica = createFont("Helvetica",80);
  showFrame = true;
  stopMonth = false;
  showErrorMsg = false;
  Textfield Date1 = cp5.addTextfield("date1")
                       .setPosition(100, 10)
                       .setSize(70, 20)
                       .setFont(createFont("Helvetica",15))
                       .setFocus(true)
                       .setColor(color(0))
                       .setAutoClear(false)
                       .setColorBackground(color(255))
                       .setColorActive(color(255))
                       .setColorForeground(color(255))
                       .setCaptionLabel("Please Enter A Month in YYYY/MM format")
                       ;
  Date1.getCaptionLabel().getStyle().marginTop  = -20; 
  Date1.getCaptionLabel().getStyle().marginLeft  = 75;
  
  Textfield Date2 = cp5.addTextfield("date2")
                       .setPosition(400,10)
                       .setSize(70,20)
                       .setFont(createFont("Helvetica",15))
                       .setFocus(false)
                       .setColor(color(0))
                       .setAutoClear(false)
                       .setColorBackground(color(255))
                       .setColorActive(color(255))
                       .setColorForeground(color(255))
                       .setCaptionLabel("Enter the second Month to compare in YYYY/MM format");
  Date2.getCaptionLabel().getStyle().marginTop  = -20; 
  Date2.getCaptionLabel().getStyle().marginLeft  = 75;

  cp5.setAutoDraw(false);
  
  // get value and deweyClasses name hashmap 
  deweyTable = loadTable("data/deweyClasses.csv");
  deweyMap = new HashMap<Integer,String>();
  for(int i=0; i<deweyTable.getRowCount(); i++){
    if(deweyTable.getInt(i,0) == 0 || deweyTable.getInt(i,0) % 100 == 0){
      deweyMap.put(deweyTable.getInt(i,0),deweyTable.getString(i,1)); 
    }
  }
  
  // get names array and initialize data arraylist
  deweyNames = new String[deweyMap.size()];
  deweyData = new ArrayList<ArrayList<Category>>();
  for(int i =0; i<deweyMap.size(); i++){
    deweyNames[i] = deweyMap.get(i*100);
    deweyData.add(new ArrayList<Category>());
  }
  table = loadTable("data/output2.csv", "header");
  numRows = table.getRowCount();
  for(int i=0; i<numRows; i++){
    int year = table.getInt(i,0);
    int deweyNumber = table.getInt(i,2);
    String month = table.getString(i,1);
    String categoryName = deweyMap.get(deweyNumber);
    int count = table.getInt(i,3);
    int index = deweyNumber / 100;
    deweyData.get(index).add(new Category(deweyNumber, categoryName, year, month, count));
  }
  for (int i=0; i<deweyData.size(); i++) { 
    pointsOne.add(new ArrayList<PVector>());
    pointsTwo.add(new ArrayList<PVector>());
    pointsThree.add(new ArrayList<PVector>());
  }
  for (int i=0; i<deweyData.size(); i++) {
    for(int j=0; j < deweyData.get(i).size(); j++){
      float x1 = deweyData.get(i).get(j).x1;
      float y1 = deweyData.get(i).get(j).y1;
      float x2 = deweyData.get(i).get(j).x2;
      float y2 = deweyData.get(i).get(j).y2;
      PVector pointOne = new PVector(0, 0, LAYER_DIST*(13-int(deweyData.get(i).get(j).month)));
      pointsOne.get(i).add(pointOne);
      
      PVector pointTwo = new PVector(x1, y1,  LAYER_DIST*(13-int(deweyData.get(i).get(j).month)));
      pointsTwo.get(i).add(pointTwo);

      PVector pointThree = new PVector(x2, y2,  LAYER_DIST*(13-int(deweyData.get(i).get(j).month)));
      pointsThree.get(i).add(pointThree);
        
    }
  }
}

void draw(){
  background(#d0dae8);
  colorMode(HSB); 
  // drawMainFrame and Month Label
  drawMainFrame();
  drawMonthsLabel();
  // draw center circel
  drawCenterCircle();
  //draw years
  drawYearsLabel();
  //Draw Title and legends
  GUI();
  // drawBars
  for(int i = 0; i < drawBars.length; i++){
    if (drawBars[i] < 0 || drawBars[i] >= 120 ) {
      continue;
    }
    int direction = i == 0 ? 1 : -1;
    for(int j = 0; j< deweyData.size(); j++){
      int count = deweyData.get(j).get(drawBars[i]).count;
      drawCylinderBars(j, count, direction);
      drawTop(j, count, direction);
    }
  }
}