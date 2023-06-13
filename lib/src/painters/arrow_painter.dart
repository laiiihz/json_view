import 'package:flutter/widgets.dart';

class ArrowPainter extends CustomPainter {
  ArrowPainter({
    required this.color,
    this.arrowSize = 8,
  });
  final Color color;
  final double arrowSize;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(size.width / 3, size.height / 2 - arrowSize / 2);
    path.lineTo(size.width / 3, size.height / 2 + arrowSize / 2);
    path.lineTo(size.width / 3 + arrowSize / 3 * 2, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) =>
      oldDelegate.arrowSize != arrowSize || oldDelegate.color != color;

  @override
  bool shouldRebuildSemantics(ArrowPainter oldDelegate) => false;
}
