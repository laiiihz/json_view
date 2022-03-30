import 'package:flutter/material.dart';

Size getTextSize(TextSpan span) {
  final textPainter = TextPainter(
    text: span,
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: double.infinity);
  return textPainter.size;
}
