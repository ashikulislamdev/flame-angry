import 'package:angry/actors/player.dart';
import 'package:angry/world/ground.dart';
import 'package:angry/world/obstacle.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  //to do something in main method
  WidgetsFlutterBinding.ensureInitialized();

  //to make device auto landscape and full screen
  Flame.device.setLandscape();
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends Forge2DGame with HasTappables{
  @override
  Future<void> onLoad() async{
    await super.onLoad();
    
    add(SpriteComponent()
      ..sprite = await loadSprite("angry-bg.jpg")
      ..size = size);
    
    //camera.viewport = FixedResolutionViewport(Vector2(1400, 780));
    
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);

    add(Ground(gameSize));

    add(Player());

    add(Obstacle(Vector2(60, -16), await loadSprite('pot_roped_fire.webp')));
    add(Obstacle(Vector2(60, -6), await loadSprite('old-wooden.png')));
    add(Obstacle(Vector2(60, 0), await loadSprite('wooden-box.png')));
    add(Obstacle(Vector2(60, 8), await loadSprite('wooden-box.png')));
    add(Obstacle(Vector2(60, 16), await loadSprite('wooden-box.png')));
  }
}




