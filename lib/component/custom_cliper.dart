import 'dart:math' as math;

import 'package:flutter/material.dart';

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({super.key, this.diameter = 600});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: MyPainter(), size: Size(diameter, diameter));
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint paint = Paint()..color = Colors.blue;
    // final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    final Paint paint = Paint()..color = Color(0xFF4DB749);

    final Rect rect = Rect.fromLTWH(0, -170, size.width, size.height * 2.5);

    canvas.drawArc(
      rect,
      0, // เริ่มจากฝั่งขวา
      math.pi, // วาดครึ่งล่าง (180 องศา)
      true, // ปิด path ด้านล่าง
      paint,
    );
    // }

    // canvas.drawArc(
    //   Rect.fromCenter(
    //     center: Offset(size.height / 2, size.width / 2),
    //     height: size.height,
    //     width: size.width,
    //   ),
    //   0,
    //   math.pi,
    //   true,
    //   paint,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
