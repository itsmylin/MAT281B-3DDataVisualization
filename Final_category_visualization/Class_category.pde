class Category{
  int deweyNumber;
  String categoryName;
  int year;
  String month;
  int count;
  float radius;
  float deweyColor;
  float x1;
  float y1;
  float x2;
  float y2;
  int index;
  float degree;
  
  Category(int deweyNumber, String categoryName, int year, String month, int count){
    this.deweyNumber = deweyNumber;
    this.categoryName = categoryName;
    this.year = year;
    this.month = month;
    this.count = count;
    deweyColor = deweyNumber;
    radius = map(sqrt(count),0,sqrt(250000),0,120);
    index = deweyNumber / 100;
    degree = PI / 5;
    this.x1 = radius*(float)Math.cos(degree * index);
    this.y1 = radius*(float)Math.sin(degree * index);
    this.x2 = radius*(float)Math.cos(degree * (index+1));
    this.y2 = radius*(float)Math.sin(degree * (index+1));
  }
  void draw(){
    colorMode(HSB);
    stroke(50,100);
    fill(map(deweyColor, 0, 990, 0, 255), 255/2, 255, TRANS*1.5);
    beginShape();
    vertex(0, 0);
    vertex(x1,y1);
    vertex(x2,y2);
    endShape();
  }
}