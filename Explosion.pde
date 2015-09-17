class Explosion extends Sprite {
  public float distance;
  public static final float speed = 0.3;
  public color colour;
  public float weight;
  public static final int length = 5;
  public static final int nbparticles = 25;
  
  public void move(float x, float y) {
    move();
  }
  
  public boolean finished() {
    return weight == 0;
  }
    
  public void move() {
    this.distance = this.distance + timeOffset*Explosion.speed*this.weight;
    this.weight = this.weight - timeOffset*0.001;
    
    if(this.weight < 0) this.weight = 0;
  }
  
  public void sketch() {
   stroke(this.colour);    
   strokeWeight(this.weight*5);
   
   for(int i = 0; i < nbparticles; i++) {
     float angle = 2*PI*float(i)/float(nbparticles);
     line(this.pos.x + this.distance*cos(angle),
          this.pos.y + this.distance*sin(angle),
          this.pos.x + (Explosion.length + this.distance)*cos(angle),
          this.pos.y + (Explosion.length + this.distance)*sin(angle));
   }
  }
  
  public Explosion(Position pos, boolean isFriendly) {
    this.pos.x = pos.x;
    this.pos.y = pos.y;
    this.weight = 1;
    if(isFriendly)
      colour = color(128,128,255);
    else
      colour = color(255,128,0);
  }
}