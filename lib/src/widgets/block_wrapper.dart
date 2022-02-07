import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_tile.dart';

class BlockWrapper extends StatefulWidget {
  final String keyValue;
  final Widget child;
  final Type type;
  BlockWrapper(
      {Key? key,
      required this.keyValue,
      required this.child,
      required this.type})
      : super(key: key);

  @override
  State<BlockWrapper> createState() => _BlockWrapperState();
}

class _BlockWrapperState extends State<BlockWrapper> {
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
      if (mounted)
        setState(() {
          _showMore = true;
        });
    });
  }

  void _close() {
    _showMore = false;
    setState(() {});
    // TODO when animation break
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted)
        setState(() {
          _child = SizedBox(height: 24);
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: AnimatedAlign(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            child: _child,
            heightFactor: _showMore ? 1 : 0,
          ),
        ),
        InkWell(
          onTap: () {
            if (!_showMore) {
              _open();
            } else {
              _close();
            }
          },
          child: JsonTile(
            leading: Icon(_showMore
                ? Icons.arrow_drop_down_rounded
                : Icons.arrow_right_rounded),
            title: widget.keyValue,
            value: widget.type.toString(),
          ),
        ),
      ],
    );
  }
}
