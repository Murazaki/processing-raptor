abstract class Fire extends Sprite  {
  public Position pos;
  public color colour;
  public static final int weight = 3;
  public static final int length = 7;
  
  public Fire(Position pos) {
    this.pos = pos;
  }
}