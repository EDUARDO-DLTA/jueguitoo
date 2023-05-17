import 'dart:ffi';
import 'dart:math';

import 'package:figuras_flame/figures.dart';
import 'package:jueguitoo/tap_button.dart';
import 'figuras.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'drag_input.dart';

class MyGame extends FlameGame with KeyboardEvents {
  final sizeOfFigure = Vector2(100, 200);
  final sizeOfContainer = Vector2(300, 200);
  late TextComponent colisiones;


 
  @override
  bool get debugMode => true;
  int collisionCount = 0;

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        moverIzquierda();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        moverDerecha();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void render(Canvas canvas) {
    final floower = children.query<Flower>().first;
    final DragInput drag = children.query<DragInput>().first;
    floower.position = Vector2(floower.position.x, size.y - sizeOfFigure.y);
    drag.position = Vector2(size.x / 2, size.y);

    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    children.register<Flower>();
    
    await add(colisiones = TextComponent(
        text: "colisiones: $collisionCount ", position: Vector2(0, 250)));
    await super.onLoad();

    final sizeOfContainer = Vector2(300, 200);

    await add(Flower(
        position: Vector2(size.x / 2, size.y - sizeOfFigure.y),
        paint: Paint()..color = Colors.white,
        size: sizeOfFigure));
    await add(TapButton(moverDerecha)
      ..position = Vector2(size.x - 50, 75)
      ..size = Vector2(100, 100));
    await add(TapButton(moverIzquierda)
      ..position = Vector2(50, 75)
      ..size = Vector2(100, 100));
    await add(
      DragInput((mover) {
        if (mover) {
          moverDerecha();
        } else {
          moverIzquierda();
        }
      })
        ..position = Vector2(size.x, size.y - sizeOfContainer.y)
        ..size = Vector2(size.x, sizeOfContainer.y),
    );
  }

  double tiemmof = 2;

  @override
  void update(double dt) {
    super.update(dt);
    double tamafig = Random().nextDouble();
    tiemmof += dt;

    

    for (MyBallena Ballena in children.query<MyBallena>()) {
      Ballena.position.y += 3; // Utiliza la velocidad actualizada

      // Verificar colisión con Flower
      final floower = children.query<Flower>().first;
      if (Ballena.isCollidingWith(floower)) {
        // Incrementar contador de colisiones
        collisionCount++;
        colisiones.text = 'ColisionEs: $collisionCount';

        // Eliminar la figura (ballena)
        remove(Ballena);
      }
    }
    if (tiemmof >= Random().nextInt(10) + 2) {
      add(MyBallena(
          position:
              Vector2(Random().nextDouble() * (size.x - sizeOfFigure.x), 0),
          size: Vector2(
            tamafig * sizeOfFigure.y + 15,
            tamafig * sizeOfFigure.y + 30,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tiemmof = 0;
    }
    for (MyFlower flower in children.query<MyFlower>()) {
      flower.position.y += 3; // Utiliza la velocidad actualizada

      // Verificar colisión con Flower
      final floower = children.query<Flower>().first;
      if (flower.isCollidingWith(floower)) {
        // Incrementar contador de colisiones
        collisionCount++;
        colisiones.text = 'Coliciones: $collisionCount';

        // Eliminar la figura (flower)
        remove(flower);
      }
    }
    if (tiemmof >= Random().nextInt(10) + 2) {
      add(MyFlower(
          position:
              Vector2(Random().nextDouble() * (size.x - sizeOfFigure.x), 0),
          size: Vector2(
            tamafig * sizeOfFigure.x + 15,
            tamafig * sizeOfFigure.y + 30,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tiemmof = 0;
    }
    for (MyCaballito Caballito in children.query<MyCaballito>()) {
      Caballito.position.y += 2; // Utiliza la velocidad actualizada

      // Verificar colisión con Flower
      final floower = children.query<Flower>().first;
      if (Caballito.isCollidingWith(floower)) {
        // Incrementar contador de colisiones
        collisionCount++;
        colisiones.text = 'COLISIONES: $collisionCount';

        // Eliminar la figura (caballito)
        remove(Caballito);
      }
    }
    if (tiemmof >= Random().nextInt(10) + 2) {
      add(MyCaballito(
          position:
              Vector2(Random().nextDouble() * (size.x - sizeOfFigure.x), 0),
          size: Vector2(
            tamafig * sizeOfFigure.x + 15,
            tamafig * sizeOfFigure.y + 30,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tiemmof = 0;
    }
  }

  void moverIzquierda() {
    final Flower floower = children.query<Flower>().first;
    floower.position.x -= 10;

    if (floower.position.x + floower.width < 0) {
      floower.position.x = size.x;
    }
  }

  void moverDerecha() {
    final Flower floower = children.query<Flower>().first;
    floower.position.x += 10;

    if (floower.position.x > size.x) {
      floower.position.x = -floower.size.x;
    }
  }
}
