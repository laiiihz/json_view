import 'package:flutter/material.dart';

class BlockWrapper extends StatefulWidget {
  final String keyValue;
  final Widget child;
  BlockWrapper({Key? key, required this.keyValue, required this.child})
      : super(key: key);

  @override
  State<BlockWrapper> createState() => _BlockWrapperState();
}

class _BlockWrapperState extends State<BlockWrapper> {
  bool _showMore = false;
  Widget _child = SizedBox(height: 48);

  void _open() {
    setState(() {
      _child = Padding(
        padding: EdgeInsets.only(top: 48, left: 8),
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
          _child = SizedBox(height: 48);
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
        ListTile(
          dense: true,
          leading: Icon(_showMore ? Icons.arrow_drop_down : Icons.arrow_right),
          title: Text(widget.keyValue),
          horizontalTitleGap: 0,
          onTap: () {
            if (!_showMore) {
              _open();
            } else {
              _close();
            }
          },
        ),
      ],
    );
  }
}
