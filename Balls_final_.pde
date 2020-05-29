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
