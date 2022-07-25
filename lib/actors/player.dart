import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Player extends BodyComponent with Tappable{
  @override
  Future<void> onLoad() async{
    await super.onLoad();
    renderBody = false;
    add(SpriteComponent()
      ..sprite = await gameRef.loadSprite("happy-angry.png")
      ..size = Vector2.all(6)
      ..anchor = Anchor.center
    );
  }

  @override
  Body createBody(){
    Shape shape = CircleShape()..radius = 3;
    BodyDef bodyDef = BodyDef(position: Vector2(10, 5), type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapDown(TapDownInfo info){
    body.applyLinearImpulse(Vector2(30, -10) * 1000);
    return false;
  }
}