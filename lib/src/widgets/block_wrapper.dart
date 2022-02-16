import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/animated_arrow.dart';
import 'package:json_view/src/widgets/json_tile.dart';
import 'package:json_view/src/widgets/json_view_configuration.dart';

class BlockWrapper extends StatefulWidget {
  final String keyValue;
  final Widget child;
  final String short;
  BlockWrapper(
      {Key? key,
      required this.keyValue,
      required this.child,
      required this.short})
      : super(key: key);

  @override
  State<BlockWrapper> createState() => _BlockWrapperState();
}

class _BlockWrapperState extends State<BlockWrapper> {
  Timer? _timer;
  bool _showMore = false;
  Widget _child = SizedBox(height: 24);

  void _open() {
    setState(() {
      _child = Padding(
        padding: EdgeInsets.only(top: 24, left: 8),
        child: widget.child,
      );
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
      if (mounted)
        setState(() {
          _showMore = true;
        });
    });
  }

  void _close(Duration animation) {
    _showMore = false;
    setState(() {});
    if (_timer != null) {
      _timer = Timer(animation, () {
        if (mounted)
          setState(() {
            _child = SizedBox(height: 24);
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = JsonViewConfiguration.of(context).animation;
    return Stack(
      children: [
        ClipRect(
          child: AnimatedAlign(
            alignment: Alignment.topCenter,
            duration: animation,
            curve: Curves.easeInOutCubic,
            child: _child,
            heightFactor: _showMore ? 1 : 0,
          ),
        ),
        JsonTile(
          leading: AnimatedArrow(isFold: _showMore, duration: animation),
          title: widget.keyValue,
          value: _showMore ? '' : widget.short,
          onTap: () {
            if (!_showMore) {
              _open();
            } else {
              _close(animation);
            }
          },
        ),
      ],
    );
  }
}
