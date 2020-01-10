/**
 * Line Matching code 
 * @author Haider Khan
 * Takes draw grid program and elaborates on it by when the checkline(); meets it results in a turn win statement 
 * Uses timer array to keep track of the best time, time elapsed and turns 
 * uses mouse clicked function to check the parameters of buttons  
 * Uses boolean statments to check buttons state and determining the colours of lines based on user input
 * Uses animated gifs to show if the user is victorius 
 */
 
//Timer Var
float [] times;
long startTime = 0;
long currentTime =0;
float bestTime=0;
int turnsLeft= 5;

//variables for grid
final float SLOPE_RESTRICTION = 5;
final float SLOPE_INCREMENT = 0.5;
final float YINT_INCREMENT=10;

//stae and background changing colour variable 
int state=0;
float tree = 1;

//button variables
float mouseW;
int ellipseSize=150;
int ellipseSize2=150;
int instructions=1;
float mouseH;
boolean restart=false;
boolean startGame=false;
boolean introOnly=false;
boolean testmode =true;
float buttonSelecter=0;
float m = 1;//user slope
float b = 10;//user y-intercept
float randM = 0;//the random gtarget slope
float randB = 0;//the randome target y-intercept
int startbuttonX = 480;
int startbuttonY = 250;

//variable for gif 
PImage [] frame_;
int framesmovement = 0;
int frameSkip = 5;

// colour booleans 
boolean blue = false;
boolean green = false;
boolean pink = false;

//set up function
void setup() {
  frameRate(30);
  size(1000, 1000);
  init();
  fill(0);
  textSize(12);
  //draw lines 600 long at width /2 and height /2
  //in a for loop increasing by 10 
  //draw horizontal ticks 10 apart
  //draw the horizontal labels 10 apart 
  //draw vertical ticks 10 apart
  //draw the vertical labels 10 apart
  strokeWeight(2);
  textAlign(CENTER);
  
  //setup for the timer code 
   times=new float[]{0,0,0,0,0};
   startTime= System.currentTimeMillis();
   reset();
  

  fill(0, 0, 0);
  drawAxis();
}//end setup

void init(){
  frame_ = new PImage[15];
  //for eacg unage in the array
  for(int i = 0; i < frame_.length; i++) {
      //load the images into the array
      frame_[i] = loadImage("frame_"+i+".gif");
  }
}
 
//processing funct_ions
void instructions() {
  tree = tree + 0.01;
  background(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
  textSize(100);
  fill(0,0,255);
  text("Instructions", 270, 100);
  //instructions # 1
  textSize(22);
  fill(255,0,0);
  //colour choseing intruction 
  textSize(27);
  fill(255,0,0);
  text("*Chose line Color: press 'p' for pink, press 'b' for blue, press 'g' for green*", 10, 550);
  //inttruction # 1
  textSize(22);
  fill(255,0,0);
  text("- Click screen to create a random slope on the grid ", 12, 180);
  // instruction # 2
  text("- Use the arrow keys to tranform your line until it matches the randomly generated equation", 10, 256);
  // instruction # 3 
  text("- Once you have matched your slope victory music and picture will follow", 10, 332);
  // instruction # 4
  text("- Your best time for matching the slope will be recorded so try to beat your best time!", 10, 408);
  // instruction # 5 
  text("- The game steadily gets challenging as you spend more time matching slopes and Y-ints", 10, 484);

  // draws return button
  fill(252, 8, 44);
  rect(400,600,200,100);
  fill(255);
  textSize(45);
  text("Return", 430, 661);
}
void mouseClicked() {
  getRandomValues(); 
  // when screen is clicked produce a random value 
  if (state==0 && introOnly==true) {
    state=1;
  }
  if (state==1 && restart==true){
  state=0;
  }
  if (state==0 && startGame==true){
   state=2; 
  }
  // if you are in the win state and screen is cliked return to play state 
  if (state == 3){
    state = 2;
  }
    // start best time 
}

// function that checks parameters for the start, instructions and return button 
void mousePressed() {
  //checks parameters of instrcutons button 
  if ((mouseX<555) && (mouseX>400) && (mouseY>425) && (mouseY< 580)) {
    ellipseSize=175;
    instructions=0;
   introOnly=true;
  } 
  else if (instructions==0) {
    ellipseSize=150;
    introOnly=false;
  } 
  //checks parameters of return button 
if ((mouseX>400) && (mouseX<600) && (mouseY>600) && (mouseY<700) && state==1) {
      instructions=1;
      restart=true;
  }
      else if (instructions==1){
      restart=false;
  }
  //checks pramaters for the start button 
  if ((mouseX>405) && (mouseX<555) && (mouseY>42) && (mouseY<325) && state==0){
   ellipseSize2=175;
   startGame=true;
 }
       else if (state==0){
        ellipseSize2=150; 
        startGame=false;
 }
 
}

void startScreen() {
  //background
  tree = tree + 0.01;
  background(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
  
  //game title 
  textSize(80);
  strokeWeight(25);
  stroke(255,0,0);
  fill(255,255,255);
  text("Line Matching", 250, 87);
  
  //changing line colour text
  textSize(27);
  strokeWeight(20);
  fill(255,0,0);
  text("*Chose line Color: press 'P' for Pink, press 'B' for Blue, press 'G' for Green*", 12, 700);
  
  //play button
  strokeWeight(0);
  fill(255,0,0);
  ellipse(480,250, ellipseSize2, ellipseSize2);
  fill(255, 255, 255);
  textSize(20);
  text("Start Game", 430, 262);
  
  //instructions button
  strokeWeight(0);
  fill(42,42,235);
  ellipse(480, 500, ellipseSize, ellipseSize);
  fill(252, 255, 255);
  textSize(20);
  text("Instructions", 420, 510);
}

//custom functions
void checkKeys() {
  //using if statements check to see if the keys are pressed
  if (keyCode == UP&& keyPressed) {
    //decrease y-interceptvariable b (the line will go up)
    b += YINT_INCREMENT;
  } else if (keyCode == DOWN&& keyPressed) {
    //increase y -intcpt variable b (the line will go down) 
    b-= YINT_INCREMENT;
  } else if (keyCode == LEFT&& keyPressed) {
    //increase the slope of the line (rotation of the line)
    m += SLOPE_INCREMENT;
  } else if (keyCode == RIGHT&& keyPressed) {
    //decrease the slope of the line (rotation of the line)
    m -= SLOPE_INCREMENT;
  }
}

void checkBounds() {
  // check to see if the y-intercept, |b| > 300
  //if so, set back to +/- 300
  if (b < -height/2) {
    b = -height/2;
  } else if (b > height/2) {
    b = height/2;
  }
  //check upper and lower bounds for 'm'
  if (m < -SLOPE_RESTRICTION) {
    m = -SLOPE_RESTRICTION;
  } else if (m > SLOPE_RESTRICTION) {
    m = SLOPE_RESTRICTION;
  }
  //handles slope that is too shallow
  else if (m >-SLOPE_INCREMENT &&m<0) {
    m = SLOPE_INCREMENT;
  } else if (m <SLOPE_INCREMENT &&m>0) {
    m = -SLOPE_INCREMENT;
  }
}

void checkLines() {
  if (b == randB && m==randM) {
    background(200, 200, 0);
    //pdate timr
      state = 3; //win state c
      counttime();
  }
  
}
void drawAxis() {
  stroke(0, 0, 0);
  strokeWeight(2);
  textAlign(CENTER);
  fill(0, 0, 0);
  textSize(10);
  int tickDim = 2;
  //draw lines 600 long at width /2 and height /2
  line(0, height/2, width, height/2);//hor line
  line(width/2, 0, width/2, height);//vert line
  textAlign(CENTER);
  //Horizontal tick s and labels
  //in a for loop increasing by 10 
  for (int i = 0; i <= width; i+=10) {
    //draw the thick lines and labels every 50

    if (i == width/2) {//this is where the zeros are drwn on the grid
      //do nothing because zeros look awkward
    } else if (i % 50 == 0) {//if i is a multiple of 50
      strokeWeight(2);//thicker line
      line(i, height/2- tickDim, i, height/2+tickDim);//tick      
      text((i- width/2)+"", i, height/2+8*tickDim);//label
    } else {
      //thinker unlabelled ticks
      strokeWeight(0.8);
      line(i, height/2- tickDim, i, height/2+tickDim);
    }
  }//end for loop
  textAlign(LEFT);
  //Vertical tick s and labels
  //in a for loop increasing by 10 
  for (int i = 0; i <= height; i+=10) {
    //draw the thick lines and labels every 50
    if (i == height/2) {
    } else if (i % 50 == 0) {//if i is a multiple of 50
      strokeWeight(2);//thicker line
      line(width/2- tickDim, i, width/2+tickDim, i );//tick      
      text(-1*(i- height/2)+"", width/2+5, i+10 );//label
    } else {
      //thinker unlabelled ticks
      strokeWeight(0.8);
      line(width/2- tickDim, i, width/2+tickDim, i);
    }
  }//end for loop
}

// functions that checks for line colour 
void keyPressed() {
 if(key == 'b' || key == 'b'){ // changes the line blue 
   blue = true;
 }
 if(key == 'g' || key == 'G'){ // checks if the line should be green
   green= true;
 }
 
 if(key == 'p' || key == 'P'){ // checks if the line should be pink 
   pink= true;
 }
}

void counttime(){
 
  //store the timeEllapsed in the times array
 currentTime= System.currentTimeMillis()- startTime;
 times[turnsLeft-1]=currentTime/1000.0;
 
 //check to see if latest time is better than cBest
 if(bestTime==0){//if this is our first term, set the best time
  bestTime=times[turnsLeft-1]; 
 
 }
 else if (times[turnsLeft-1]<bestTime){
  bestTime=times[turnsLeft-1]; 
   
 }
 
if(times[turnsLeft-1]< bestTime){
 bestTime= times[turnsLeft-1]; 
}
 //reset timer
 startTime= System.currentTimeMillis();
 //decriment turn by 1
  turnsLeft--;
 
  if(turnsLeft==1){
    state = 25;
  }
}

void drawLine(float _m, float _b) {
  float x_i = -width/2;//left most x value
  float x_f = width/2;//right most x value
  //given the slope and y-intcpt, solve for y if x = -300
  float y_i = -_m * x_i - _b;
  //repeat for x = width/2
  float y_f = -_m * x_f - _b;
  //draw line from first point to final point

  line(x_i+width/2, y_i+height/2, x_f+width/2, y_f+height/2);
}

void getRandomValues() {
  int max = (int)SLOPE_RESTRICTION;
  int min = -(int)SLOPE_RESTRICTION;
  int range = max - min;
  float inc = SLOPE_INCREMENT;
  int states = 0;

  do {
    //loop until the slope is not near zero
    states = (int)(random(range / inc + 1));

    randM = states * inc -(int)(range/2);
  } while (abs(randM)< inc);

  //gets rid of the stupid floating point erroes, credit to Emma
  randM *= 10;
  randM = round(randM);
  randM /= 10;


  //get random b values
  max = 300;
  min = -300;
  range = max - min;
  inc = YINT_INCREMENT;
  states = (int)(random(range / inc + 1));
  randB = states * inc -(int)(range/2);
}

void reset(){
  if(turnsLeft == 0){
  state = 25;
  }
 // bestTime=0;
 // turnsLeft= 5;
 //  times=new float[]{0,0,0,0,0};
 // startTime= System.currentTimeMillis(); 
}


void draw() {
  background(200);
  currentTime= (System.currentTimeMillis()- startTime)/1000;

  
  if (state==0) { // state = 0 draw start screen

    startScreen(); // calling start screen fucntion 
    
  }
  
  if (state==1) { // if  state = 1 than go to instructions
    instructions(); 
  }
  
  if (state == 2) { // play state all the game variables/ functions are under here 
 
 checkKeys();
 //draws text
 textSize(20);
 tree = tree + 0.01;
 fill(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
 text("Turns Left: "+ turnsLeft,680, 550);
 text("Time: "+ currentTime,680,600);
 text("Your Best time: "+bestTime,680,650);

    //check all conditions
    checkBounds(); 
    checkLines();

    //draw new frame

    drawAxis();
   if (blue == true) { // is the user input was b than the line colour will be blue 
    stroke(0,0,200);//blue user line
    drawLine(m, b);
    }
    if (green == true){ // if the user input was g than the line colour will be green
      stroke(26,255,0);
      drawLine(m,b);
    }
    if (pink == true){ // if the user input is p thant line color will be pink 
      stroke(255, 13, 251);
      drawLine(m,b);
    }
    else if (blue == false && green == false && pink == false) { // if the user did not chose a line color than draw a blue line 
      stroke(0,0,200);
      drawLine(m,b);
    }
    //random line
    stroke(255, 0, 0);//red random line
    drawLine(randM, randB);
    //draw label
    textSize(20);
    text("y = "+m+"x+"+b, 20, 40);
    text("y = "+randM+"x+"+randB, width/2 + 20, 40);
}   
  
  // turn completed state 
  if (state == 3) { 
   tree = tree + 0.01;
  background(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
   
    // add the gif 
     if (frameCount % frameSkip == 0){
  framesmovement++;
  }
  
  // check to see if framess equal to banana.length
  if(framesmovement >= frame_.length){
  
    //set frames back to 0frames = 0
 framesmovement = 0;
  }
  
  //draw the image 
  image(frame_[framesmovement], 200,180);
  textSize(40);
  fill(255,255,255);
  text("Your Best Time: "+bestTime,320,96);
  
  //further instructions to continue the game 
  textSize(26);
  strokeWeight(20);
  fill(255,0,0);
  text("*Click the screen to start your next turn! Try to beat your current best time!*", 14, 700);
}

//game win state 
if (state == 25) {
  tree = tree + 0.01;
  background(sin(tree)*293, sin(tree)*199 + 250, cos(tree+5)*125);
  textSize(25);
  fill(255,255,255);
  text("Congratulations you have finished your game!", 250, 100);
 
 // changing line colour text
  textSize(23);
  strokeWeight(20);
  fill(255,0,0);
  text("*Good Job! Hope this simulation gave you a good understanding of the Slope Unit*", 18, 700);
  
  //second statement
  textSize(21);
  strokeWeight(20);
  fill(255,0,0);
  text("*If you wish to replay and beat your best time ask the program developer to replay the game*", 15, 800);
  
  // add victory gif 
 if (frameCount % frameSkip == 0){
  framesmovement++;
  }
  
  // check to see if framess equal to banana.length
  if(framesmovement >= frame_.length){
  
    //set frames back to 0frames = 0
  framesmovement = 0;
  }
  
  //draw the image 
  image(frame_[framesmovement], 200,180);
  textSize(40);
  fill(255,255,255);
  text("Your Best Time: "+bestTime,300,70);
  }
 
 // testing mode displays x and y coordinates 
  if (testmode) {
      fill(0);
      textSize(15);
      text(mouseX+ " " + mouseY, mouseX, mouseY); 
      mousePressed();
  } 
}