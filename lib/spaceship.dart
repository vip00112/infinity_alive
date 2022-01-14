import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:infinity_alive/global.dart';
import 'package:infinity_alive/missile.dart';

class SpaceShip extends SpriteComponent with Draggable, HasHitboxes, Collidable {
  SpaceShip() : super(size: Vector2.all(32));

  late Vector2 startPosition;

  bool isLoadedFirst = false;

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('ship.png');
    anchor = Anchor.center;
    startPosition = position;

    final hitbox = HitboxRectangle(relation: Vector2.all(0.5));
    addHitbox(hitbox);

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    if (!isLoadedFirst) {
      isLoadedFirst = true;

      position = gameSize / 2;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (Global.isPause() || Global.isOver()) return;
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    if (Global.isPause() || Global.isOver()) return false;

    final localCoords = info.eventPosition.game;
    startPosition = localCoords - position;
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    if (Global.isPause() || Global.isOver()) return false;

    final localCoords = info.eventPosition.game;
    position = localCoords - startPosition;
    return false;
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Missile) {
      Global.status = GameStatus.gameover;
    }
  }

  void restart() {
    position.x = Global.deviceWidth / 2;
    position.y = Global.deviceHeight / 2;
  }
}
