public class Stop extends Drawable {
  
  public PVector pos;
  public String name;

  public Stop(float x, float y, String name) {
    this.pos = new PVector(x,y);
    this.name = name;
  }

  public void show() {
    push();
    translate(pos.x, pos.y);
    fill(40);
    stroke(240, 0, 0);
    strokeWeight(2);
    rectMode(CENTER);
    rect(0, 0, 40, 40);
    fill(80);
    textSize(20);
    text(name, -25, 50);
    pop();
  }

  public String toString() {
    return name;
  }
}