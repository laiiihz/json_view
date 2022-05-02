import 'package:flutter/widgets.dart';

import '../painters/arrow_painter.dart';
import 'json_config.dart';

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
    final JsonConfig config = JsonConfig.of(context);
    final cs = config.color!;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: RotatedBox(
          quarterTurns: _turn,
          child: CustomPaint(
            painter: ArrowPainter(
              color: cs.markColor,
            ),
            size: const Size(8, 8),
          ),
        ),
      ),
    );
  }
}
