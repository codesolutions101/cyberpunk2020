import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';

/// Draws a circle if placed into a square widget.
class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = AppColor.themeColor
    ..strokeWidth = 10
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomCirclePainter extends CustomPainter {
  CustomCirclePainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomCirclePainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class RectanglePainter extends CustomPainter {
  final _paint = Paint()
    ..color = AppColor.themeColor
    ..strokeWidth = 4
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(10.0)),
        _paint);
//    canvas.drawDRRect(
//      RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, size.width, size.height),
//          topLeft: Radius.circular(50)),
//      RRect.fromRectAndCorners(Rect.fromLTWH(10, 10, size.width, size.height),
//          topLeft: Radius.circular(1)),
//      _paint,
//    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
