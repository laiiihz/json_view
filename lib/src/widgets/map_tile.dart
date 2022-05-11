import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';

import 'arrow_widget.dart';
import 'simple_tiles.dart';

class MapTile extends StatefulWidget {
  final String keyName;
  final List<MapEntry> items;
  final bool expanded;
  final Widget? arrow;
  MapTile({
    Key? key,
    required this.keyName,
    required this.items,
    this.expanded = false,
    this.arrow,
  }) : super(key: key);

  @override
  State<MapTile> createState() => _MapTileState();
}

class _MapTileState extends State<MapTile> {
  late bool _expanded = widget.expanded;

  String get _value {
    if (widget.items.isEmpty) return '{}';
    if (_expanded) return '';
    return '{...}';
  }

  void changeState() {
    if (widget.items.isNotEmpty)
      setState(() {
        _expanded = !_expanded;
      });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: JsonConfig.of(context).customArrowAnimationDuration ??
          Duration(milliseconds: 300),
      curve: JsonConfig.of(context).customArrowAnimationCurve ?? Curves.ease,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KeyValueTile(
            keyName: widget.keyName,
            value: _value,
            onTap: changeState,
            leading: widget.items.isEmpty ? null : _arrowWidget,
            valueWidget: _expanded
                ? Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.items.map((item) {
                        return getParsedItem(
                          item.key,
                          item.value,
                          false,
                          widget.arrow,
                        );
                      }).toList(),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget get _arrowWidget => widget.arrow == null
      ? ArrowWidget(
          direction: _expanded ? ArrowDirection.down : ArrowDirection.right,
          onTap: changeState,
        )
      : MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: changeState,
            child: AnimatedRotation(
              turns: _expanded ? 0 : -.25,
              duration: JsonConfig.of(context).customArrowAnimationDuration ??
                  Duration(milliseconds: 300),
              curve: JsonConfig.of(context).customArrowAnimationCurve ??
                  Curves.ease,
              child: widget.arrow,
            ),
          ),
        );
}
