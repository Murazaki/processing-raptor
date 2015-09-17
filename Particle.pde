class Particle extends Sprite {
  public float speed;
  public static final int nbparticles = 50;
  public static final int lengthFactor = 50;
  
  public float length() {
    return this.speed*Particle.lengthFactor;
  }
  
  public color colour() {
    return color(192.*this.speed);
  }
  
  public float weight() {
    return this.speed;
  }
  
  public void move(float x, float y) {
    move();
  }
    
  public void move() {
    this.pos.x = this.pos.x - timeOffset*this.speed;
    
    if(pos.x + this.length() < 0) {
      pos.x = width;
      this.pos.y = int(random(0,height));
    }
    else if(pos.x > width) {
      pos.x = - this.length();
      this.pos.y = int(random(0,height));
    }
  }
  
  public void sketch() {
   stroke(this.colour());    
   strokeWeight(this.weight());
   line(this.pos.x,this.pos.y,this.pos.x + this.length(),this.pos.y);
  }
  
  public Particle() {
  }
}