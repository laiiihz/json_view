import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedArrow extends ImplicitlyAnimatedWidget {
  final bool isFold;
  const AnimatedArrow({required this.isFold, required Duration duration})
      : super(
          duration: duration,
          curve: Curves.easeInOutCubic,
        );

  @override
  _AnimatedArrowState createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends AnimatedWidgetBaseState<AnimatedArrow> {
  Tween<double>? _tween;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _tween?.evaluate(animation) ?? 0,
      child: Icon(Icons.arrow_right_rounded),
      origin: Offset(4, 0),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(_tween, widget.isFold ? pi / 2 : 0.0,
        (dynamic value) => Tween<double>(begin: value)) as Tween<double>?;
  }
}
