public abstract class Drawable {
  
  protected void drawBase() {
    push();
    strokeWeight(2);
    stroke(255, 255, 0);
    line(0, 0, 100, 0);
    stroke(0, 255, 255);
    line(0, 0, 0, 100);
    pop();
  }

  //protected abstract void drawAttr();

}