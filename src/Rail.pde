import java.util.Iterator;

public class Rail extends Drawable {
  
  public Stop start;
  public Stop end;
  public Rail next;
  public float length;
  public ArrayList<Train> trains;

  public Rail(Stop start, Stop end, Rail next) {
    this.start = start;
    this.end = end;
    this.next = next;
    this.length = getVect().mag();
    trains = new ArrayList<Train>();
  }

  public void show() {
    push();
    stroke(200, 20, 20);
    strokeWeight(2);
    translate(start.pos.x, start.pos.y);
    rotate(getAngle());
    line(0, 0, getVect().mag(), 0);
    pop();
    start.show();
    end.show();
  }

  public void showTrains() {
    for (Train t : trains) {
      t.show();
    }
  }

  public void update() {
    Iterator<Train> it = trains.iterator();
    while (it.hasNext()) {
      Train t = it.next();
      t.trafic = Rails.Trafic.CRUISE;
      if (t.pos > this.length - t.MIN_DIST_APPROACH) {
        t.trafic  = Rails.Trafic.APPROACH;
      }
      if (t.pos > this.length - t.MIN_DIST_SLOW) {
        t.trafic  = Rails.Trafic.SLOW;
      }
      if (t.pos > this.length - t.MIN_DIST_QUAY) {
        t.trafic  = Rails.Trafic.QUAY;
      }
      if (t.pos > this.length) {
        t.pos = 0;
        t.rail = next;
        if (start.name.equals("MLVC") && end.name.equals("MLVC"))
          t.code = Trains.CodePARIS.gen();
        if (!end.name.equals("NSYG"))
          next.trains.add(t);
        it.remove();
      }
      t.update();
    }
  }

  public void addTrain(String name) {
    this.trains.add(new Train(this, name));
  }

  public PVector getVect() {
    return PVector.sub(end.pos, start.pos);
  }

  public float getAngle() {
    PVector r = getVect();
    if (r.y >= 0)
      return PVector.angleBetween(r, new PVector(1,0));
    else
      return -PVector.angleBetween(r, new PVector(1,0));
  }

  public PVector getNormalVect() {
    if (getVect().dot(new PVector(1, 0)) > 0)
      return getVect().rotate(-PI / 2).normalize();
    else if (getVect().dot(new PVector(1, 0)) < 0)
      return getVect().rotate(PI / 2).normalize();
    else if (getAngle() == PI/2)
      return new PVector(0, -1);
    else if (getAngle() == -PI/2)
      return new PVector(0, -1);
    else
      return null;
  }

  public String toString() {
    return start + "->" + end;
  }
}
