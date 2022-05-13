import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../json_view.dart';
import '../painters/arrow_painter.dart';

class ArrowWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final bool expanded;
  final Widget? customArrow;

  const ArrowWidget({
    Key? key,
    this.onTap,
    this.expanded = false,
    this.customArrow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JsonConfigData config = JsonConfig.of(context);
    final cs = config.color ?? JsonConfigData.defaultColor(context);
    late Widget arrow;

    if (customArrow != null) {
      arrow = IconTheme(
        data: IconThemeData(color: cs.normalColor, size: 16),
        child: customArrow!,
      );
    } else {
      arrow = CustomPaint(
        painter: ArrowPainter(color: cs.markColor ?? Colors.black),
        size: const Size(16, 16),
      );
    }

    if (config.animation ?? JsonConfigData.kUseAnimation) {
      arrow = AnimatedRotation(
        turns: expanded ? .25 : 0,
        duration: config.animationDuration ?? JsonConfigData.kAnimationDuration,
        curve: config.animationCurve ?? JsonConfigData.kAnimationCurve,
        child: arrow,
      );
    } else {
      arrow = Transform.rotate(
        angle: expanded ? .25 * math.pi * 2.0 : 0,
        child: arrow,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: arrow,
      ),
    );
  }
}
