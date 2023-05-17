import 'dart:ui';
import 'package:figuras_flame/figures.dart';
import 'package:flame/components.dart';

class MyBallena extends Ballena {
  MyBallena(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}

class MyCaballito extends Caballito {
  MyCaballito(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}

class MyFlower extends Flower {
  MyFlower(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}
