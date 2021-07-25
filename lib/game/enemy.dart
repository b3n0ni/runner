import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';

enum EnemyType { Bee, BlueBird, Bunny, Chicken, Duck, FatBird, Rocks, Skull }

class EnemyData {
  final String imageName;
  final int textureHeight;
  final int textureWidth;
  final int nColumns;
  final int nRows;

  const EnemyData({
    @required this.imageName,
    @required this.textureHeight,
    @required this.textureWidth,
    @required this.nColumns,
    @required this.nRows,
  });
}

class Enemy extends AnimationComponent {
  int speed = 200;
  Size size;
  int textureWidth;
  int textureHeight;
  static const Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.Bee: EnemyData(
      imageName: 'Attack (36x34).png',
      nColumns: 8,
      nRows: 1,
      textureHeight: 34,
      textureWidth: 36,
    ),
    EnemyType.BlueBird: EnemyData(
      imageName: 'Flying (32x32).png',
      nColumns: 9,
      nRows: 1,
      textureHeight: 32,
      textureWidth: 32,
    ),
    EnemyType.Bunny: EnemyData(
      imageName: 'Run (34x44).png',
      nColumns: 12,
      nRows: 1,
      textureHeight: 44,
      textureWidth: 34,
    ),
    EnemyType.Chicken: EnemyData(
      imageName: 'Run (32x34).png',
      nColumns: 14,
      nRows: 1,
      textureHeight: 34,
      textureWidth: 32,
    ),
    EnemyType.Duck: EnemyData(
      imageName: 'Jump Anticipation (36x36).png',
      nColumns: 4,
      nRows: 1,
      textureHeight: 36,
      textureWidth: 36,
    ),
    EnemyType.FatBird: EnemyData(
      imageName: 'Ground (40x48).png',
      nColumns: 4,
      nRows: 1,
      textureHeight: 48,
      textureWidth: 40,
    ),
    EnemyType.Rocks: EnemyData(
      imageName: 'Rock1_Run (38x34).png',
      nColumns: 14,
      nRows: 1,
      textureHeight: 34,
      textureWidth: 38,
    ),
    EnemyType.Skull: EnemyData(
      imageName: 'Attack (36x34).png',
      nColumns: 1,
      nRows: 1,
      textureHeight: 36,
      textureWidth: 34,
    ),
  };
  Enemy(EnemyType myType) : super.empty() {
    final enemyData = _enemyDetails[myType];
    final spriteSheet = SpriteSheet(
      imageName: enemyData.imageName,
      textureHeight: enemyData.textureHeight,
      textureWidth: enemyData.textureWidth,
      columns: enemyData.nColumns,
      rows: enemyData.nRows,
    );
    this.animation = spriteSheet.createAnimation(0,
        from: 0, to: enemyData.nColumns - 1, stepTime: 0.1);
    textureHeight = enemyData.textureHeight;
    textureWidth = enemyData.textureWidth;
  }
  @override
  void resize(Size size) {
    super.resize(size);
    double scaleFactor = (size.width / numberOfTilesAlongWidth) / textureWidth;
    this.height = textureHeight * scaleFactor;
    this.width = textureWidth * scaleFactor;
    this.x = size.width + this.width;
    this.y = size.height - groundHeight - this.height;
    this.size = size;
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= speed * t;
  }

  @override
  bool destroy() {
    return (this.x < (-this.width));
  }
}
