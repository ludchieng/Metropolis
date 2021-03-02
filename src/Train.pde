public class Train extends Drawable {

  public float XMAX_VEL = 35 / (float) 1000;
  public float MAX_VEL = 25 / (float) 1000;
  public float MAX_ACC = 5 / (float) 1000;

  public float MIN_MARGIN_TRAIN = 100;

  public float MIN_DIST_CRUISE = 50;
  public float MIN_DIST_APPROACH = 25;
  public float MIN_DIST_SLOW = 12.5;
  public float MIN_DIST_QUAY = 2.5;

  public String id;
  public String code;

  public float length;

  public Rail rail;
  public Rails.Trafic trafic;

  public float pos;
  public float vel;
  public float acc;

  public Train (Rail r, String code) {
    this.code = code;
    this.id = Trains.genId();
    this.length = 40;
    Random rand = new Random();
    MAX_VEL += rand.nextInt(24) - 12;
    rail = r;
    pos = 0;
    vel = 0;
    acc = 0.005;
  }

  public void show() {
    push();
    translate(rail.start.pos.x, rail.start.pos.y);
    rotate(rail.getAngle());
    translate(0, -8);
    translate(pos, 0);
    //drawBase();
    drawAttr();
    fill(0, 0);
    stroke(240);
    strokeWeight(2);
    rectMode(CENTER);
    rect(0, 0, length, 16);
    pop();
  }

  public void drawAttr() {
    push();
    int offset = 20;
    int sizeX = 75;
    int sizeY = 55;
    PVector diag = new PVector(sizeX, sizeY);
    PVector v = rail.getVect().normalize();
    PVector coef = new PVector(v.dot(new PVector(1,0)), v.dot(new PVector(0,1)));
    translate(0, - (diag.x * abs(coef.y) + diag.y * abs(coef.x)) / 2);
    translate(0, -offset);
    rotate(-rail.getAngle());

    //strokeWeight(2);
    //stroke(255, 0, 255);
    //fill(0, 0);
    //rectMode(CORNERS);
    //rect(-sizeX/2, -sizeY/2, sizeX/2, sizeY/2);

    translate(-sizeX/2, -sizeY/2);
    fill(0, 255, 255);
    textSize(22);
    text(id, 0, 15);
    text(code, 0, 35);
    text(trafic.toString(), 0, 55);
    //text("vel: " + Float.toString(vel).substring(0, 3), 0, 28);
    pop();
  }

  public void update() {
    float dist = rail.length - pos;
    for (Train t : rail.trains) {
      float margin = t.pos - t.length/2 - MIN_MARGIN_TRAIN - pos;
      if (t != this && margin < dist && t.pos - pos > 0)
        dist = margin;
    }
    
    if (dist > MIN_DIST_APPROACH) {
      trafic = Rails.Trafic.CRUISE;
    } else if (dist > MIN_DIST_SLOW) {
      trafic = Rails.Trafic.APPROACH;
    } else if (dist > MIN_DIST_QUAY) {
      trafic = Rails.Trafic.SLOW;
    } else {
      trafic = Rails.Trafic.QUAY;
    }

    if (vel > trafic.maxVel + 0.001) {
      acc = -MAX_ACC;
    } else if (vel < trafic.maxVel - 0.001) {
      acc = MAX_ACC;
    } else {
      acc = 0;
    }
      vel += acc;
      pos += vel;
  }
}
