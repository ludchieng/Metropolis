public static final class Rails {
  
  public enum Trafic {
    CRUISE(0.5, "Cruise"),
    APPROACH(0.25, "Approch"),
    QUAY(0.025, "Quay"),
    SLOW(0.125, "Breaking");

    public float maxVel;
    public String alias;

    private Trafic(float mv, String al) {
      maxVel = mv;
      alias = al;
    }

    public float maxVel() {
      return maxVel;
    }

    public String toString() {
      return alias;
    }
  }
}