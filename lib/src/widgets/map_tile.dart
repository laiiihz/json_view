import 'package:flutter/material.dart';

import '../models/json_config_data.dart';
import 'json_config.dart';
import 'json_view.dart';
import 'simple_tiles.dart';

class MapTile extends StatefulWidget {
  final String keyName;
  final List<MapEntry> items;
  final bool expanded;
  final int depth;
  const MapTile({
    Key? key,
    required this.keyName,
    required this.items,
    this.expanded = false,
    required this.depth,
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
    final jsonConfig = JsonConfig.of(context);
    Widget result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MapListTile(
          keyName: widget.keyName,
          value: _value,
          onTap: _changeState,
          expanded: _expanded,
          showLeading: widget.items.isNotEmpty,
        ),
        if (_expanded)
          Padding(
            padding: jsonConfig.itemPadding ?? const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.items.map((item) {
                return getParsedItem(
                  key: item.key,
                  value: item.value,
                  depth: widget.depth + 1,
                );
              }).toList(),
            ),
          ),
      ],
    );
    if (jsonConfig.animation ?? JsonConfigData.kUseAnimation) {
      result = AnimatedSize(
        alignment: Alignment.topCenter,
        duration: JsonConfig.of(context).animationDuration ??
            const Duration(milliseconds: 300),
        curve: JsonConfig.of(context).animationCurve ?? Curves.ease,
        child: result,
      );
    }

    return result;
  }
}
