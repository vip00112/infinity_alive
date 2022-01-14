enum GameStatus { pause, run, gameover }

class Global {
  static GameStatus status = GameStatus.gameover;

  static double deviceWidth = 0;
  static double deviceHeight = 0;
  static double gameSpeed = 50;
  static double score = 0;
  static int level = 1;

  static bool isPause() => status == GameStatus.pause;
  static bool isRun() => status == GameStatus.run;
  static bool isOver() => status == GameStatus.gameover;
}
