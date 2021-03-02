import java.util.ArrayList;
import java.util.Random;
ArrayList<Rail> rails = new ArrayList<Rail>();
Random rand = new Random();

Stop[] sts = {
  new Stop(100, 300, "NSYG"),
  new Stop(359, 250, "NCHP"),
  new Stop(610, 255, "NSIL"),
  new Stop(754, 320, "LOGN"),
  new Stop(925, 280, "TRCY"),
  new Stop(1325, 350, "BSSY"),
  new Stop(1708, 180, "VALE"),
  new Stop(1820, 100, "MLVC")
};

float cScale = 0.5;
int xView = 0;
int yView = 0;
int trainCount = 1;

void setup() {
  size(970, 270);
  link(sts, rails);
  Trains.createTrain(rails.get(0));
}

void draw() {
  if (frameCount % 500 == 0) {
    Trains.createTrain(rails.get(0));
  }
  background(40);
  scale(cScale, cScale);
  for (Rail r : rails) {
    r.update();
    r.show();
  }
  for (Rail r : rails) {
    r.showTrains();
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    int num = rand.nextInt(89) + 10;
    rails.get(6).addTrain("THOT" + num);
  }
}

// ~

void link(Stop[] sts, ArrayList<Rail> rails) {
  int iLastSt = sts.length - 1;
  Rail lastRail = new Rail(sts[0], sts[0], null);
  Rail nRail = lastRail;
  Rail cRail;
  int i = 0;
  for (; i < iLastSt; i++) {
    cRail = new Rail(sts[i+1], sts[i], nRail);
    nRail = cRail;
  }
  cRail = new Rail(sts[iLastSt], sts[iLastSt], nRail);
  nRail = cRail;
  for (; i > 0; i--) {
    cRail = new Rail(sts[i-1], sts[i], nRail);
    nRail = cRail;
  }
  lastRail.next = nRail;

  Rail firstRail = cRail;
  while (cRail.next != firstRail) {
    rails.add(cRail);
    cRail = cRail.next;
  }
  rails.add(lastRail);
}
