import 'package:flutter/material.dart';

import '../../json_view.dart';
import 'arrow_widget.dart';
import 'simple_tiles.dart';

class MapTile extends StatefulWidget {
  final String keyName;
  final List<MapEntry> items;
  final bool expanded;
  final Widget? arrow;
  const MapTile({
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

  _changeState() {
    if (mounted && widget.items.isNotEmpty) {
      setState(() {
        _expanded = !_expanded;
      });
    }
  }

  String get _value {
    if (widget.items.isEmpty) return '{}';
    if (_expanded) return '';
    return '{ ... }';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: JsonConfig.of(context).animationDuration ??
          const Duration(milliseconds: 300),
      curve: JsonConfig.of(context).animationCurve ?? Curves.ease,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KeyValueTile(
            keyName: widget.keyName,
            value: _value,
            onTap: _changeState,
            leading: widget.items.isEmpty
                ? null
                : ArrowWidget(
                    expanded: _expanded,
                    onTap: _changeState,
                    customArrow: widget.arrow,
                  ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.items.map((item) {
                  return getParsedItem(
                    item.key,
                    item.value,
                    widget.arrow,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
