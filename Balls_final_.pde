ArrayList<Ball> balls = new ArrayList<Ball>();
int size = 0; 

void setup() {
  size(800,800);
  background(0,0,0);
  frameRate(1000);
}

void draw() {
  background(0,0,0);
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (i > j) {
        Ball a = balls.get(i);
        Ball b = balls.get(j);
        a.collide(b);
      }
    }
  }
  for (int i = 0; i < size; i++) {
    Ball b = balls.get(i);
    b.wall();
    b.evolve();
    b.display();
  }
}

void mousePressed() {
  balls.add(new Ball());
  size = balls.size();
  Ball b = balls.get(size-1);
  b.display();
}

class Ball {
  float xpos;
  float ypos;
  float diameter = 100;
  float xvel = random(-0.5,0.5);
  float yvel = random(-0.5,0.5);
  boolean collision = false;

  Ball() {
    xpos = mouseX;
    ypos = mouseY;
  }
  
  void display() {
    strokeWeight(3);
    noFill();
    ellipse(xpos, ypos, diameter, diameter);
   }
  
  void evolve() {
    if (collision) {
      stroke(255,0,0);
    } else {
      stroke(0,255,255);
    }
    collision = false;
    xpos = xpos + xvel;
    ypos = ypos + yvel;
  }
  
  void wall() {
    if (xpos + diameter/2 > width || xpos < diameter/2) {
      xvel = -xvel;
    }
    if (ypos + diameter/2> height || ypos < diameter/2) {
      yvel = -yvel; 
    }
  }
  
  boolean collide(Ball other) {
    if (dist(xpos, ypos, other.xpos, other.ypos) < diameter/2 + other.diameter/2) {
      collision = true;
      other.collision = true;
      
      float deltax = xpos - other.xpos;
      float deltay = ypos - other.ypos;
      float vx1i = xvel; 
      float vy1i = yvel;  
      float vx2i = other.xvel;
      float vy2i = other.yvel;
      
      xvel = ( vx1i*deltay*deltay + vx2i*deltax*deltax - vy1i*deltax*deltay + vy2i*deltax*deltay ) / ( deltax*deltax + deltay*deltay );
      yvel = ( -vx1i*deltax*deltay + vx2i*deltax*deltay + vy1i*deltax*deltax + vy2i*deltay*deltay ) / ( deltax*deltax + deltay*deltay );
      other.xvel = ( vx1i*deltax*deltax + vx2i*deltay*deltay + vy1i*deltax*deltay - vy2i*deltax*deltay ) / ( deltax*deltax + deltay*deltay );
      other.yvel = ( vx1i*deltax*deltay - vx2i*deltax*deltay + vy1i*deltay*deltay + vy2i*deltax*deltax ) / ( deltax*deltax + deltay*deltay );
      
      float x1f = xpos + xvel;
      float y1f = ypos + yvel;
      float x2f = other.xpos + other.xvel;
      float y2f = other.ypos + other.yvel;
      float distf = dist(x1f, y1f, x2f, y2f);
      
      if (distf < diameter/2 + other.diameter/2) {
        float overlap = diameter/2 + other.diameter/2 - distf;
        float evolvesteps = overlap / dist(xvel, yvel, other.xvel, other.yvel) + 0.25;
        xpos = xpos + evolvesteps*xvel;
        ypos = ypos + evolvesteps*yvel;
        other.xpos = other.xpos + evolvesteps*other.xvel;
        other.ypos = other.ypos + evolvesteps*other.yvel;
      }
      
      return true;
    } else {
      return false;
    }
  }
}
