import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Player extends BodyComponent with Tappable{
  late AudioPool launchGameAudio;
  late AudioPool flyingAudio;
  
  @override
  Future<void> onLoad() async{
    await super.onLoad();

    launchGameAudio = await AudioPool.create("audio/Launch.mp3", maxPlayers: 1);
    flyingAudio = await AudioPool.create("audio/bird-flying.mp3", maxPlayers: 1);

    renderBody = false;
    add(SpriteComponent()
      ..sprite = await gameRef.loadSprite("happy-angry.png")
      ..size = Vector2.all(6)
      ..anchor = Anchor.center);
      FlameAudio.bgm.initialize();
      FlameAudio.bgm.play("birds-intro.mp3", volume: 0.5);
      Future.delayed(const Duration(seconds: 10), () => FlameAudio.bgm.stop());
  }

  @override
  Body createBody(){
    Shape shape = CircleShape()..radius = 3;
    BodyDef bodyDef = BodyDef(userData: this, position: Vector2(10, 5), type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapDown(TapDownInfo info){

    launchGameAudio.start(volume: 0.8);
    FlameAudio.bgm.stop();
    Future.delayed(
      const Duration(milliseconds: 1000), () => flyingAudio.start(volume: 0.8)
    );

    body.applyLinearImpulse(Vector2(30, -10) * 1000);
    return false;
  }
}