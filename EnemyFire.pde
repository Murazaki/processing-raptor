class EnemyFire extends Fire {
  public float speed;
  public Enemy whoShot; // Hint : It's not Han Solo
  
  public void move(float x, float y) {
    move();
  }
  
  public void move() {
    this.pos.x -= timeOffset*this.speed;
  }
  
  public void sketch() {
   stroke(this.colour);    
   strokeWeight(Fire.weight);
   line(this.pos.x,this.pos.y,this.pos.x + Fire.length,this.pos.y);  
  }  
  
  public EnemyFire(Enemy whoShot, Position pos) {
    super(pos);
    speed = 0.3;
    this.whoShot = whoShot;
    colour = color(255,0,0);
  }
}