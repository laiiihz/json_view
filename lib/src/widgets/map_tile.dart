import 'package:flutter/material.dart';

import 'arrow_widget.dart';
import 'json_config.dart';
import 'json_view.dart';
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
    final config = JsonConfig.of(context);
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KeyValueTile(
          keyName: widget.keyName,
          value: _value,
          onTap: changeState,
          leading: widget.items.isEmpty
              ? null
              : ArrowWidget(
                  expanded: _expanded,
                  onTap: changeState,
                  customArrow: widget.arrow,
                ),
        ),
        if (_expanded)
          Padding(
            padding: config.itemPadding ?? JsonConfigData.kItemPadding,
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
          ),
      ],
    );
    if (config.animation ?? JsonConfigData.kUseAnimation) {
      child = AnimatedSize(
        alignment: Alignment.topLeft,
        duration: config.animationDuration ?? JsonConfigData.kAnimationDuration,
        curve: config.animationCurve ?? JsonConfigData.kAnimationCurve,
        child: child,
      );
    }
    return child;
  }
}
