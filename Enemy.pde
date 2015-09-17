class Enemy extends Sprite {
  public Position speed;
  
  public void move(float x, float y) {
    move(); // Enemies move on their own
  }
  
  public void fire() {
    enemyFireList.add(new EnemyFire(this, new Position(pos.x - size.width/2, pos.y)));
  }
  
  public void move() {
    speed.y += randomGaussian()*0.001;
    
    if(speed.y > 0.02)
      speed.y = 0.02;
    if(speed.y < -0.02)
      speed.y = -0.02;
    
    pos.x -= timeOffset*speed.x;
    pos.y += timeOffset*speed.y;
    
    if(pos.y > height - size.height)
      pos.y = height - size.height;
    if(pos.y < size.height)
      pos.y = size.height;
  }
  
  public void sketch() {
    stroke(255,0,0);
    fill(128,0,0);
    rect(pos.x - size.width/2,pos.y - size.height/2,size.width,size.height);    
  }
  
  public Enemy(float y) {
    size.width = 10;
    size.height = 10;
    
    speed = new Position(0.15,0);
    
    pos.x = width + size.width/2;
    pos.y = y;
  } 
}