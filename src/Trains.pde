public static class Trains {

  public static void createTrain(Rail r) {
    String code;
    if (r.start.name == "NSYG") {
      code = CodeMLVC.gen();
    } else if (r.start.name == "MLVC") {
      code = CodePARIS.gen();
    } else {
      code = CodeSPECIAL.gen();
    }
    r.addTrain(code);
  }

  public static String genId() {
    Random r = new Random();
    int num1 = r.nextInt(2) + 16;
    int num2 = (r.nextInt(43) + 5) * 2 + 1;
    return "" + num1 + num2 + "/" + (num2+1);
  }

  public enum CodeMLVC {
    QBIK, QIKY, QIWI, QLOE,
    QLUB, QPID;

    public static CodeMLVC rand() {
      Random r = new Random();
      return values()[(int) r.nextInt(values().length)];
    }

    public static String gen() {
        Random r = new Random();
        int num = r.nextInt(89) + 10;
      return CodeMLVC.rand().toString() + num;
    }
  }


  public enum CodePARIS {
    BORA, TBON, TERI, UBOS, UKRA,
    ZEBU, ZEUS, ZITA;

    public static CodePARIS rand() {
      Random r = new Random();
      return values()[(int) r.nextInt(values().length)];
    }

    public static String gen() {
        Random r = new Random();
        int num = r.nextInt(89) + 10;
      return CodePARIS.rand().toString() + num;
    }
  }


  public enum CodeSPECIAL {
    ECAR, ECRI, EDUR, XILO,XANO,
    XOUD,XUTI ;

    public static CodeSPECIAL rand() {
      Random r = new Random();
      return values()[(int) r.nextInt(values().length)];
    }

    public static String gen() {
        Random r = new Random();
        int num = r.nextInt(89) + 10;
      return CodePARIS.rand().toString() + num;
    }
  }

}
