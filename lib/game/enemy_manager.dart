import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:runner/game/enemy.dart';
import 'package:runner/game/game.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  Random _random;
  Timer _timer;
  int _spawnLevel;
  EnemyManager() {
    _random = Random();
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
  }
  void spawnRandomEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomNumber);
    final newEnemy = Enemy(randomEnemyType);
    gameRef.addLater(newEnemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double t) {
    _timer.update(t);

    var newSpawnLevel = (gameRef.score ~/ 500);
    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;

      _timer.stop();
      var newWaitTime = (4 / (1 + (0.1 * _spawnLevel)));
      _timer = Timer(newWaitTime, repeat: true, callback: () {
        spawnRandomEnemy();
      });
      _timer.start();
    }
  }

  void reset() {
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
    _timer.start();
  }
}
