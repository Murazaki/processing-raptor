class FriendlyFire extends Fire {
  public float speed;
  public Player whoShot; // Hint : It's not Han Solo
  
  public void move(float x, float y) {
    move();    
  }
  
  public void move() {
    this.pos.x += timeOffset*this.speed;
  }
  
  public void sketch() {
   stroke(this.colour);    
   strokeWeight(Fire.weight);
   line(this.pos.x - Fire.length,this.pos.y,this.pos.x,this.pos.y);    
  }
  
  public FriendlyFire(Player whoShot, Position pos) {
    super(pos);
    speed = 0.3;
    this.whoShot = whoShot;
    colour = color(0,255,0);
    
    friendlyFireList.add(this);
  }
}