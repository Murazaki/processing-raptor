abstract class Sprite {
  public Position pos = new Position();
  public Size size = new Size();
  
  public abstract void move(float x, float y);
  public abstract void move();
  public abstract void sketch();
}