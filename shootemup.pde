import java.util.Iterator;

PFont myFont;
Particle[] particles;
Player[] players;
float lastFrame = 0;
float timeOffset = 0;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<FriendlyFire> friendlyFireList = new ArrayList<FriendlyFire>();
ArrayList<EnemyFire> enemyFireList = new ArrayList<EnemyFire>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
ArrayList<Character> keysPressed = new ArrayList<Character>();
boolean gameOver = false;

void setup() {
  size(1000, 500);
  myFont = createFont("Arial Bold", 16);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  
  initLevel();
}

void initLevel() {
  // Clear values and populate players and stars background
  players = null;
  particles = null;
  enemies.clear();
  friendlyFireList.clear();
  enemyFireList.clear();
  explosions.clear();
  
  players = new Player[Player.nbplayers];
  particles = new Particle[Particle.nbparticles];
  
  for (int i = 0; i < Player.nbplayers; i++) {
    players[i] = new Player(i);
  }  
  for (int i = 0; i < Particle.nbparticles; i++) {
    particles[i] = new Particle();
    particles[i].pos.x = random(0, width);
    particles[i].pos.y = random(0,height);
    particles[i].speed = random(0.01,0.75);
  }
  
  gameOver = false;
}

void keyPressed()
{
  if(!keysPressed.contains(key))
    keysPressed.add(new Character(key));
}

void keyReleased()
{
  if(keysPressed.contains(key))
    keysPressed.remove(new Character(key));
} 

void draw() {
  timeOffset =  millis() - lastFrame;
  
  if(gameOver && explosions.isEmpty()) {
    background(0,0,16);
    
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("GAME OVER", width/2, height/2);
    
    // Press a key to restart game
    if(keyPressed) {
      initLevel();
    }
    
    return;
  }
    
  
  // Manage new elements
  updateLevel();
  
  // Movements here
  manageEvents();
  
  // Collisions here
  manageCollisions();
  
  // Draw HERE
  background(0,0,16);
  
  for(int i = 0; i <Particle.nbparticles;i++)
    particles[i].sketch();
  
  for(int i = 0; i <Player.nbplayers;i++)
    players[i].sketch();
    
  for(Enemy enemy: enemies)
    enemy.sketch();
  
  for(FriendlyFire friendlyFire: friendlyFireList)
    friendlyFire.sketch();
  
  for(EnemyFire enemyFire: enemyFireList)
    enemyFire.sketch();
    
  for(Explosion explosion: explosions)
    explosion.sketch();
  //END Draw
  
  lastFrame = millis();
}

void updateLevel() {
  for (Iterator<Enemy> it = enemies.iterator(); it.hasNext(); ) {
    Enemy enemy = it.next();
    if (enemy.pos.x - enemy.size.width/2 < 0)
        it.remove();
  }
  
  for (Iterator<FriendlyFire> it = friendlyFireList.iterator(); it.hasNext(); ) {
    FriendlyFire friendlyFire = it.next();
    if(friendlyFire.pos.x - Fire.length > width)
        it.remove();
  }
  
  for (Iterator<EnemyFire> it = enemyFireList.iterator(); it.hasNext(); ) {
    EnemyFire enemyFire = it.next();
    if(enemyFire.pos.x + Fire.length < 0)
        it.remove();
  }
  for (Iterator<Explosion> it = explosions.iterator(); it.hasNext(); ) {
    Explosion explosion = it.next();
    if (explosion.finished())
        it.remove();
  }
  
  if(abs(millis() % 500) < 15) {
    enemies.add(new Enemy(random(0, height - 20) + 10));
  }
  
  if(abs(millis() % 500) < 15) {
    for(Enemy enemy: enemies) {
      if(random(0,10) > 7)
        enemy.fire();
    }
  }
  
}

void manageEvents() {  
  // background moves  
  for(int i = 0; i <Particle.nbparticles;i++) {
    particles[i].move();
  }
  
  for(int i = 0; i <Player.nbplayers;i++) {    
    if(!players[i].isDead()) {    
      float x,y;
      x = 0;
      y = 0;
      
      if(keysPressed.contains(players[i].key_up)) {
        y -= 1;
      }
      if(keysPressed.contains(players[i].key_down)) {
        y = 1;
      }
      if(keysPressed.contains(players[i].key_left)) {
        x -= 1;
      }
      if(keysPressed.contains(players[i].key_right)) {
        x = 1;
      }
      if(keysPressed.contains(players[i].key_fire)) {
        players[i].fire();
      }
      players[i].move(x,y);    
    }
  }
    
  for(Enemy enemy: enemies)
    enemy.move();
  
  for(FriendlyFire friendlyFire: friendlyFireList)
    friendlyFire.move();
  
  for(EnemyFire enemyFire: enemyFireList)
    enemyFire.move();
    
  for(Explosion explosion: explosions)
    explosion.move();
}

void manageCollisions() {
  for (Iterator<EnemyFire> enemyFireIt = enemyFireList.iterator(); enemyFireIt.hasNext(); ) {
    EnemyFire enemyFire = enemyFireIt.next();
    for(int i = 0; i <Player.nbplayers;i++) {
      if(!players[i].isDead()) {
        if ((enemyFire.pos.x > players[i].pos.x - players[i].size.width/2)
            && (enemyFire.pos.x < players[i].pos.x + players[i].size.width/2)
            && (enemyFire.pos.y > players[i].pos.y - players[i].size.height/2)
            && (enemyFire.pos.y < players[i].pos.y + players[i].size.height/2)) {
            explosions.add(new Explosion(enemyFire.pos, true));
            enemyFireIt.remove();
            players[i].damaged(2);
            
            if(players[i].isDead()) gameOver = true;
            
            break;
        }
      }
    }    
  }
  
  for (Iterator<FriendlyFire> friendlyFireIt = friendlyFireList.iterator(); friendlyFireIt.hasNext(); ) {
    FriendlyFire friendlyFire = friendlyFireIt.next();
    for (Iterator<Enemy> enemyIt = enemies.iterator(); enemyIt.hasNext(); ) {
      Enemy enemy = enemyIt.next();
      if ((friendlyFire.pos.x > enemy.pos.x - enemy.size.width/2)
          && (friendlyFire.pos.x < enemy.pos.x + enemy.size.width/2)
          && (friendlyFire.pos.y > enemy.pos.y - enemy.size.height/2)
          && (friendlyFire.pos.y < enemy.pos.y + enemy.size.height/2)) {
          friendlyFire.whoShot.score += 100;
          explosions.add(new Explosion(friendlyFire.pos, false));
          enemyIt.remove();
          friendlyFireIt.remove();
          break;
      }
    }  
  }
  
  for (Iterator<Enemy> enemyIt = enemies.iterator(); enemyIt.hasNext(); ) {
    Enemy enemy = enemyIt.next();
    for(int i = 0; i <Player.nbplayers;i++) {
      if(!players[i].isDead()) {
        if ((enemy.pos.x + enemy.size.width/2 > players[i].pos.x - players[i].size.width/2)
            && (enemy.pos.x - enemy.size.width/2 < players[i].pos.x + players[i].size.width/2)
            && (enemy.pos.y + enemy.size.height/2 > players[i].pos.y - players[i].size.height/2)
            && (enemy.pos.y - enemy.size.height/2 < players[i].pos.y + players[i].size.height/2)) {
            explosions.add(new Explosion(enemy.pos, false));
            explosions.add(new Explosion(players[i].pos, true));
            enemyIt.remove();
            players[i].damaged(2);
            
            if(players[i].isDead()) gameOver = true;
            
            break;
        }
      }
    }    
  }
  
  
}