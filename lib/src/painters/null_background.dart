import 'package:flutter/material.dart';

class NullPaint {
  NullPaint._();

  static final NullPaint _instance = NullPaint._();

  static NullPaint get instance => _instance;

  Paint paint(Color color) {
    Paint result = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    return result;
  }
}
