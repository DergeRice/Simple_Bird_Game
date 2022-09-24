//declare


int[] RanLocation= new int[4];
int[] location =new int[4];

int point=0;
int crash =0;
int birdHeight=100;
int birdLoX=200;
int birdLoY=175;
int birdXsize=150;
int birdYsize=100;
int jumpVal=0;
int jumpDelay =0;
  int col=0;
  int checkbox;
int lv;
float rot =0;
float realrot =0;

PImage birdimg;
PImage back;
PImage uplog;
PImage downlog;
PImage heart;

int speedlv;
  int life;
int WallLo=700;
int RandomLo =int(random(300));
 int develop;

//setup
void wallsetup(){//basic wall set

     for(int i=0;i<4;i++){

      location[i]=700+(400*(i+1));
       RanLocation[i]=int(random(300));
     }
     
   }
   
void setup(){
  wallsetup();
  size(1500, 800);
  smooth();
  noStroke();
  back=loadImage("back.png");
  textSize(50);
  birdimg = loadImage("bird.png");
  uplog =loadImage("uplog.png");
  downlog =loadImage("downlog.png");
  heart = loadImage("heart.png");
  life = 3;
  speedlv=2;
  develop=0;


}

void draw(){

  frameRate(60);
  fill(164,215,223);
  //rect(0,0,1500,800);
  background(back);
  fill(255);
  //mouse trackin
  //bird drawing
  birddraw();
  
  //wall drawing
  walldraw();
  //collison event 
  checkcol();
  //wall recycle and point
  wallRe();
  lifedraw();
  deathcheck();
  levelup();
  develop();
  fill(0);

}

void birddraw(){//draw bird 

  jumpDelay+=1;
  birdLoY+=2;
  if(birdLoY>800){
    birdLoY= 150;
    damageDelay=2;
    damage();
  }
  if(life>-1){
  pushMatrix();
 
  translate(birdLoX, birdLoY);
  rotate(rot);
  image(birdimg,-(1/2)*birdXsize,-(1/2)*birdYsize,birdXsize,birdYsize);
  
  if(jumpDelay>20){
    if(jumpVal==1){
    image(birdimg,-(1/2)*birdXsize,-(1/2)*birdYsize,birdXsize,birdYsize);
    rot=-0.4;
    jumpDelay=0;
    jumpVal=0;
    birdLoY-=100;
    }
  }
  
if(rot<1){rot+=0.01;}
if(rot<-2){rot=-2;}
popMatrix();
}
}
void keyPressed()
{

    if(key==' '){
      jumpVal=1;
      birddraw();
  }
  if(key=='q'){
    if(checkbox==0){checkbox=1;}
    else if(checkbox!=0){checkbox=0;}
  }
  if(key=='w'){
        if(develop==0){develop=1;}
    else if(develop!=0){develop=0;}
  }
}

void deathcheck(){//check life 0
  if(life<0){
    
    textSize(300);
    text("DIED",300,300);
    textSize(50);
    text("your point=",400,500);
    text(point,700,500);
    
  }
}
void develop(){//developer mode on off
  text("POINT:",100,50);
  text(point,300,50);
  if (develop==1){
 
  text(rot,50,100);
  text(jumpDelay,50,150);
  text(lv,200,200);
  text(damageDelay,200,50);
  }
}
void levelup(){//when gain over 100, lv up

 
    lv=point/100;
    if(lv>0){
  if(point==lv*100){
    
        textSize(200);
    text("LEVEL UP",300,300);
    textSize(50);
    speedlv=2+lv;
  }
  }
}
  
void lifedraw(){//draw life img
  for(int i=0;i<life;i++)
  image(heart,100*i+100,50,100,100);
}

 void wallmove(){//moving wall up to lv

    for(int i=0;i<4;i++){
       if(life>-1){location[i]-=speedlv;}
       
     }
 }
   int damageDelay=0;
  void walldraw(){
     wallmove();
     for(int i=0; i<4;i++){
       image(uplog,location[i],0, 100, RanLocation[i]);
       image(downlog,location[i],RanLocation[i]+300, 100,800-RanLocation[i]+300);
     }
   }

  void checkcol(){//collsion chcek, wall, item
    if(checkbox==1){
    pushMatrix();
      translate(birdLoX, birdLoY);
    rect(-(1/2)*birdXsize,-(1/2)*birdYsize,birdXsize,birdYsize);
    popMatrix();
    }
    for(int i=0;i<4;i++){
      if(location[i]>birdLoX-((1/2)*birdXsize)){
        if(location[i]<birdLoX+birdXsize){
          if(birdLoY<RanLocation[i]){
          crash =1;
          col=1;
          damage();
        }
        if(birdLoY+birdYsize>RanLocation[i]+300){
          crash =1;
          damage();
        }
      }
    }else if(location[i]<birdLoX+birdXsize){
      damageDelay=0;
    }
  }
}
  

void wallRe(){//wall recycle when reach end of screen
  

  for(int i=0;i<4;i++){
    if(location[i]<0){
      location[i]=1600;
      RanLocation[i]=int(random(300));
      point=point+10-(crash*10);
      crash = 0;
    }
  }
}

//damage effect /when damaged, turn screen red
void damage(){
  if(life>-1){
  damageDelay+=1;//deamgedelay time
  if(damageDelay==2){
   
  point = point -10;
 
  life -=1;
  
  }
  fill(255,0,0,63);
  rect(0,0,1500,800,40);
  if(damageDelay>150){

  damageDelay=0;
  }
  }
}
