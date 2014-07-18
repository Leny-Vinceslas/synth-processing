 // Draw the CRT filter
void filterCRT()
{
  strokeWeight(1);
  stroke(0,255,0);
  line(width/2,0,width/2,(0+160));
  int j=0;
  
  for(int i=0;i<(0+160); i+=4)  
  {
    if(j%4==0)
    { 
      strokeWeight(1);
      stroke(0,255,0);
      line(width/2-1,i,width/2+1,i);
    }
    strokeWeight(2);
    stroke(0,80);
    line(0,i,width,i);
    j++;
  }
      strokeWeight(1);
      stroke(0,255,0);
      line(width/2-1,0+160,width/2+1,0+160);
      line(0,80,width,80);
      textFont(fontA, 11);
      fill(0,255,0);
      text("1",width/2+3,10);
      text("-1",width/2-3,0+160+10);
}
