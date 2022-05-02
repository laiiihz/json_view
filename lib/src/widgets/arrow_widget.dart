import 'package:flutter/material.dart';

import '../painters/arrow_painter.dart';

enum ArrowDirection {
  left,
  right,
  up,
  down,
}

class ArrowWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final ArrowDirection direction;
  const ArrowWidget(
      {Key? key, this.onTap, this.direction = ArrowDirection.right})
      : super(key: key);
  int get _turn {
    switch (direction) {
      case ArrowDirection.left:
        return 2;
      case ArrowDirection.right:
        return 0;
      case ArrowDirection.up:
        return 3;
      case ArrowDirection.down:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: RotatedBox(
          quarterTurns: _turn,
          child: CustomPaint(
            painter: ArrowPainter(
              color:
                  Theme.of(context).textTheme.bodyText1?.color ?? Colors.black,
            ),
            size: const Size(8, 8),
          ),
        ),
      ),
    );
  }
}
