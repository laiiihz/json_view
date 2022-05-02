import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'package:json_view/src/painters/arrow_painter.dart';
import 'package:json_view/src/widgets/arrow_widget.dart';
import 'package:json_view/src/widgets/simple_tiles.dart';

class MapTile extends StatefulWidget {
  final String keyName;
  final List<MapEntry> items;
  MapTile({Key? key, required this.keyName, required this.items})
      : super(key: key);

  @override
  State<MapTile> createState() => _MapTileState();
}

class _MapTileState extends State<MapTile> {
  bool _expanded = false;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KeyValueTile(
          keyName: widget.keyName,
          value: _value,
          onTap: changeState,
          leading: widget.items.isEmpty
              ? null
              : ArrowWidget(
                  direction:
                      _expanded ? ArrowDirection.down : ArrowDirection.right,
                  onTap: changeState,
                ),
        ),
        if (_expanded)
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.items.map((item) {
                return getParsedItem(item.key, item.value);
              }).toList(),
            ),
          ),
      ],
    );
  }
}
