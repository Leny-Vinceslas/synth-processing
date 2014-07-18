//                   SYNTHEZIZER
//            MUSIC AND AUDIO PROCESSING LAB
//                       LAB 2
//                  LENY VINCESLAS
//                    AHMED NAGI
//
//to use the synthesizer press one or several white buttons and move the frequency or the magnitude potentiometer


// Import library needed //////////
import ddf.minim.*; 
import ddf.minim.signals.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*;

// Declarations //////////////////
Minim minim;
AudioOutput out;
SineWave sine1;
SineWave sine2;
SquareWave sqW;
SawWave saw;
WhiteNoise white;
PinkNoise pink;
Potar potarfreq1;
Potar potaramp1;
Potar potarfreq2;
Potar potaramp2;
Potar potarfreq3;
Potar potaramp3;
Potar potarfreq4;
Potar potaramp4;
Pixel pixel1;
Pixel pixel2;
Pixel pixel3;
Pixel pixel4;
PFont fontA;                            
boolean p1, p2, p3, p4;
int f1,f2,f3,a1,a2,a3,a4,a5;

// Setup /////////////////////
void setup() 
{ 
  size(800,500);                            // screen size
  
  potarfreq1 = new Potar(50,380);          //initialisation potentiometer 	
  potaramp1 = new Potar(110,380);          //initialisation potentiometer 
  potarfreq2 = new Potar(250,380);         //initialisation potentiometer  
  potaramp2 = new Potar(310,380);          //initialisation potentiometer 
  potarfreq3 = new Potar(450,380);         //initialisation potentiometer  
  potaramp3 = new Potar(510,380);          //initialisation potentiometer 
  potarfreq4 = new Potar(650,380);         //initialisation potentiometer  
  potaramp4 = new Potar(710,380);          //initialisation potentiometer 
  pixel1 = new Pixel (80,220);             //initialisation buton
  pixel2 = new Pixel (280,220);            //initialisation buton
  pixel3 = new Pixel (480,220);            //initialisation buton
  pixel4 = new Pixel (680,220);            //initialisation buton
  
   minim = new Minim(this);                // call the audio library
   
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO);
  
  // create the wave function Oscillator
  sine1 = new SineWave(0, 0, out.sampleRate());  // sine wave
  white = new WhiteNoise(0);                      // white noise
  pink = new PinkNoise(0);                        // pink noise
  saw = new SawWave(0, 0, out.sampleRate());      // saw wave
  sqW = new SquareWave(0, 0, out.sampleRate());   // square wave
  
  // set the portamento speed on the oscillator to 200 milliseconds for smooth variation.
  sine1.portamento(200);
  sqW.portamento(200);
  saw.portamento(200);
  
  // map the oscillator to the line out
  out.addSignal(sine1);
  out.addSignal(white);
  out.addSignal(sqW); 
  out.addSignal(saw);
  out.addSignal(pink);
  
  // disable all outputs but keep them mapped
  out.disableSignal(sine1);
  out.disableSignal(white);
  out.disableSignal(sqW); 
  out.disableSignal(saw);
  out.disableSignal(pink);
  
  //graphical anti-alliazing 
  smooth();                            
 
 // load the font from the folder data
  fontA = loadFont("CourierNew36.vlw");  
} 
 
//Draw in the window/////////////////////////// 
void draw() 
{ 
  background(0);                            // background color
  pixel1.display();                         // display button 
  pixel2.display();                         // display button 
  pixel3.display();                         // display button 
  pixel4.display();                         // display button 
  pixel1.changcolor();                     // apply the color changing if it is pressed
  pixel2.changcolor();                     // apply the color changing if it is pressed
  pixel3.changcolor();                     // apply the color changing if it is pressed
  pixel4.changcolor();                     // apply the color changing if it is pressed
  drawCarre();                           //draw on the button
  drawSine();                            //draw on the button
  drawSaw();                              //draw on the button
  drawNoise();                            //draw on the button
  potarfreq1.display();                    // display the potentiometer
  potaramp1.display();                     // display the potentiometer
  potarfreq2.display();                    // display the potentiometer                     
  potaramp2.display();                    // display the potentiometer 
  potarfreq3.display();                    // display the potentiometer                     
  potaramp3.display();                    // display the potentiometer 
  potarfreq4.display();                    // display the potentiometer                     
  potaramp4.display();                    // display the potentiometer 
  
  //stroke(255);
  
  // draw the waveforms
  displayBackGroundVisu();
  for(int i = 0; i < out.bufferSize() - 1; i++) 
 { 
   strokeWeight(1); 
   stroke(0,255,0); 
   float x1 = map(i, 0, out.bufferSize(), 0, width); 
   float x2 = map(i+1, 0, out.bufferSize(), 0, width); 
   if ((abs(out.left.get(i))<1)&& (abs(out.left.get(i+1))<1))
   {
     line(x1, 80 + out.left.get(i)*80, x2, 80 + out.left.get(i+1)*80); 
   }
 }
 // draw the green filter
  filterCRT();
  
  //load the font and color
  textFont(fontA, 11);
  fill(0,255,0,30);
  text("by Leny Vinceslas & Ahmed Nagi",0,10);  
  fill(255);
  // display the value of the potentiometer
  int f1 = int(potarfreq1.valeur*1000);
  text("Freq: "+f1,20,265);
  int  a1 = int(potaramp1.valeur*10);
  text("Amp:0."+a1,100,265);
  int f2 = int(potarfreq2.valeur*1000);
  text("Freq: "+f2,220,265);
  int  a2 = int(potaramp2.valeur*10);
  text("Amp:0."+a2,300,265);
  int f3 = int(potarfreq3.valeur*1000);
  text("Freq: "+f3,420,265);
  int  a3 = int(potaramp3.valeur*10);
  text("Amp:0."+a3,500,265);
  int  a4 = int(potarfreq4.valeur*10);
  text("Amp:0."+a4,620,265);
  int  a5 = int(potaramp4.valeur*10);
  text("Amp:0."+a5,700,265);
  
  // if the mouse is pressed on the potentiometer
  if(mousePressed) 
  { 
    // print the values
    println(potarfreq1.valeur);            
    println(potaramp1.valeur);
    println(potarfreq2.valeur);           
    println(potaramp2.valeur);
    
     // if the mouse press the potentiometer then move it and actualize the oscilator values
    if(potarfreq1.check(mouseX,mouseY)) 
    {  
      potarfreq1.move(mouseY);               // catch the mouse Y position
      sine1.setFreq(potarfreq1.valeur*1000); // change the value of the oscilator
    } 
    
    if(potaramp1.check(mouseX,mouseY)) 
    {   
      potaramp1.move(mouseY); 
      sine1.setAmp(potaramp1.valeur);
    } 
    
    if(potarfreq2.check(mouseX,mouseY)) 
    {  
      potarfreq2.move(mouseY); 
      sqW.setFreq(potarfreq2.valeur*1000);
    } 
    
    if(potaramp2.check(mouseX,mouseY)) 
    {   
      potaramp2.move(mouseY);
      sqW.setAmp(potaramp2.valeur); 
    } 
    if(potarfreq3.check(mouseX,mouseY)) 
    {  
      potarfreq3.move(mouseY); 
      saw.setFreq(potarfreq3.valeur*1000);
    } 
    
    if(potaramp3.check(mouseX,mouseY)) 
    {   
      potaramp3.move(mouseY); 
      saw.setAmp(potaramp3.valeur);
    } 
    
    if(potarfreq4.check(mouseX,mouseY)) 
    {  
      potarfreq4.move(mouseY);
      pink.setAmp(potarfreq4.valeur);     
    } 
    
    if(potaramp4.check(mouseX,mouseY)) 
    {   
      potaramp4.move(mouseY); 
      white.setAmp(potaramp4.valeur); 
    }   
  }  
}

// If the mouse press the button, change the color and turn on/off the output/////
void mousePressed()  
{  
  if(pixel1.pospix(mouseX,mouseY)) 
  {  
    if(p1)
    {
       out.disableSignal(sine1);  
       p1=false;
    }
    else
    {
      out.enableSignal(sine1);
      p1=true;
    }
  }
  if(pixel2.pospix(mouseX,mouseY)) 
  {  
    if(p2)
    {
       out.disableSignal(sqW);  
       p2=false;
    }
    else
    {
      out.enableSignal(sqW);
      p2=true;
    }
  }
  if(pixel3.pospix(mouseX,mouseY)) 
  {  
    if(p3)
    {
       out.disableSignal(saw);  
       p3=false;
    }
    else
    {
      out.enableSignal(saw);
      p3=true;
    }
  }
  if(pixel4.pospix(mouseX,mouseY)) 
  {  
    if(p4)
    {
       out.disableSignal(pink); 
       out.disableSignal(white); 
       p4=false;
    }
    else
    {
      out.enableSignal(pink);
      out.enableSignal(white);
      p4=true;
    }
  }
}


// display function for the background//////
void  displayBackGroundVisu()
{
 rectMode(CORNER);
  noStroke();
  fill(0,255,0,30);
  rect(0,0,width,160);
}

// Function drawing the sine sign /////
void drawSine()
{
  
   for(int i=pixel1.x-pixel2.taille/4; i<= pixel1.x+pixel2.taille/4;i++)
  {
    stroke(0);
    line(i,(pixel2.taille/4)*sin(i/PI)+pixel1.y,i-1,(pixel2.taille/4)*sin((i-1)/PI)+pixel1.y);
  }
}


// Function drawing the sqare sign /////
void drawCarre()
{
  strokeWeight(1);
  stroke(0);
  line(pixel2.x-pixel2.taille/4,pixel2.y-pixel2.taille/4,pixel2.x,pixel2.y-pixel2.taille/4);
  line(pixel2.x,pixel2.y+pixel2.taille/4,pixel2.x,pixel2.y-pixel2.taille/4);
  line(pixel2.x,pixel2.y+pixel2.taille/4,pixel2.x+pixel2.taille/4,pixel2.y+pixel2.taille/4);
  
}

// Function drawing the saw sign /////
void drawSaw()
{
  strokeWeight(1);
  stroke(0);
  line(pixel3.x-pixel3.taille/3,pixel3.y+pixel3.taille/4,pixel3.x,pixel3.y-pixel3.taille/4);
  line(pixel3.x,pixel3.y+pixel3.taille/4,pixel3.x,pixel3.y-pixel3.taille/4);
  line(pixel3.x,pixel3.y+pixel3.taille/4,pixel3.x+pixel3.taille/4,pixel3.y+pixel3.taille/4);
  
}

// Function writing the noise sign /////
void drawNoise()
{
textFont(fontA, 14);
      fill(0);
      text("NOISE",pixel4.x-20,pixel4.y+5);
}

// turn of the audio fuction befor closing
void stop() 
{ 
  out.close(); 
  minim.stop(); 
  super.stop(); 
}  
