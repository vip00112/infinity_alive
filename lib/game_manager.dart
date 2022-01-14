import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:infinity_alive/global.dart';
import 'package:infinity_alive/menu_overlay.dart';
import 'package:infinity_alive/missile.dart';
import 'package:infinity_alive/spaceship.dart';

class GameManager extends FlameGame with HasDraggables, HasCollidables {
  late SpaceShip spaceShip;
  late MenuOverlay menu;
  final List<Missile> missiles = [];

  int createCount = 50;

  @override
  Future<void>? onLoad() async {
    Global.deviceWidth = size[0];
    Global.deviceHeight = size[1];

    spaceShip = SpaceShip();
    add(spaceShip);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (Global.isPause()) return;
    if (Global.isOver()) {
      menu.refreshScreen();
      return;
    }

    if (createCount > 0) {
      var missile = Missile();
      add(missile);
      missiles.add(missile);
      createCount--;
    }

    Global.score += dt;

    if (Global.score >= Global.level * 10 && Global.level <= 20) {
      Global.level++;
      Global.gameSpeed += 10;
      createCount += 5;
    }
    menu.refreshScreen();
  }

  void restart() {
    for (var missile in missiles) {
      remove(missile);
    }
    missiles.clear();
    createCount = 50;
    spaceShip.restart();
    Global.level = 1;
    Global.gameSpeed = 100;
    Global.score = 0;
    Global.status = GameStatus.run;
  }
}
