class Player extends Sprite  {
  public int score;
  public int HP;
  public static final int nbplayers = 1;
  public static final int speedmax = 10;
  public char key_up;
  public char key_down;
  public char key_left;
  public char key_right;
  public char key_fire;
  public Position speed;
  
  public void move(float x, float y) {    
    if(x == 0) speed.x /= 2;
    if(y == 0) speed.y /= 2;  
    
    if(speed.x * x < 0) speed.x = x; // check sign
    if(speed.y * y < 0) speed.y = y; // check sign
    
    speed.x += x;
    speed.y += y;
    
    if(speed.x > speedmax) speed.x = speedmax;
    if(speed.y > speedmax) speed.y = speedmax;  
    
    pos.x += speed.x;
    pos.y += speed.y;
    
    if(pos.x < size.width) pos.x = size.width;
    else if(pos.x > width - size.width) pos.x = width - size.width;
    
    if(pos.y < size.height) pos.y = size.height;
    else if(pos.y > height - size.height) pos.y = height - size.height;
  }
  
  public void fire() {
    friendlyFireList.add(new FriendlyFire(this,new Position(pos.x + size.width/2, pos.y)));
  }
  
  public void damaged(int damage) {
    HP -= damage;
    
    if(HP < 0) HP = 0;
  }
  
  public boolean isDead() {
    return (HP <= 0);
  }
  
  public void move() {
    
  }
  
  public void sketch() { 
    if(HP > 0) {
      stroke(0,0,255);
      fill(0,0,128);
      rect(pos.x - size.width/2,pos.y - size.height/2,size.width,size.height);
    }
    
    fill(255);
    textAlign(LEFT, TOP);
    textSize(16);
    text("SCORE : " + score, 10, 10);
    text("HP : " + HP, 10, 30);
  }
  
  public Player(int playerNumber) {
    size.width = 10;
    size.height = 10;
    
    score = 0;
    HP = 10;
    
    speed = new Position(0,0);
    pos.x = size.width;
    pos.y = height/2;
    
    switch(playerNumber) {
      case 0:   key_up =      'z';
                key_down =    's';
                key_left =    'q';
                key_right =   'd';
                key_fire =   'f';
                break;
      default:  break;
    }
  }
}