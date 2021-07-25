import 'dart:ui';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:runner/game/enemy_manager.dart';
import 'dino.dart';

class DinoGame extends BaseGame with TapDetector {
  Dino _dino;
  TextComponent _scoreText;
  int score;
  EnemyManager _enemyManager;
  ParallaxComponent _parallaxComponent;
  DinoGame() {
    _parallaxComponent = ParallaxComponent(
      [
        ParallaxImage('plx-1.png'),
        ParallaxImage('plx-2.png'),
        ParallaxImage('plx-3.png'),
        ParallaxImage('plx-4.png'),
        ParallaxImage('plx-5.png'),
        ParallaxImage('plx-6.png', fill: LayerFill.none),
      ],
      baseSpeed: Offset(100, 0),
      layerDelta: Offset(20, 0),
    );

    add(_parallaxComponent);
    _dino = Dino();
    add(_dino);
    _enemyManager = EnemyManager();
    add(_enemyManager);
    score = 0;
    _scoreText = TextComponent(score.toString());
    add(_scoreText);
  }
  @override
  void resize(Size size) {
    super.resize(size);
    _scoreText.setByPosition(
        Position(((size.width / 2) - (_scoreText.width / 2)), 0));
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    _dino.jump();
  }

  @override
  void update(double t) {
    super.update(t);
    score += (60 * t).toInt();
    _scoreText.text = score.toString();
  }
}
