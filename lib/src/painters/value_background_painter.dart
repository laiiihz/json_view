import 'package:flutter/material.dart';

//TODO more customizable value background
class ValueBackgroundPainter extends CustomPainter {
  final Color color;
  final Radius radius;
  ValueBackgroundPainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    canvas.drawRRect(
      RRect.fromLTRBR(0, 0, size.width, size.height, radius),
      paint,
    );
  }

  @override
  bool shouldRepaint(ValueBackgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ValueBackgroundPainter oldDelegate) => false;
}
