import 'package:angry/actors/enemy.dart';
import 'package:angry/actors/player.dart';
import 'package:angry/world/ground.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Obstacle extends BodyComponent with ContactCallbacks{
  final Vector2 position;
  final Sprite sprite;
  late final AudioPool woodCollision;

  Obstacle(this.position, this.sprite);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(
      SpriteComponent()
      ..sprite = sprite
      ..anchor = Anchor.center
      ..size = Vector2.all(5)
    );
    woodCollision = await AudioPool.create("audio/wood-collision.mp3", maxPlayers: 4);
  }

  @override
  Body createBody(){
    final shape = PolygonShape();
    var verticals = [
      Vector2(-2, -2),
      Vector2(2, -2),
      Vector2(2, 2),
      Vector2(-2, 2),
    ];
    shape.set(verticals);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3);
    BodyDef bodyDef = BodyDef(userData: this, position: position, type: BodyType.dynamic);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beingContact(Object other, Contact contact){
    super.beginContact(other, contact);
    if (other is Ground || other is Player || other is Enemy) {
      woodCollision.start();
    }
  }
}