import 'package:flutter/material.dart';

import '../models/json_config_data.dart';
import 'json_config.dart';
import 'json_view.dart';
import 'simple_tiles.dart';

class MapTile extends StatefulWidget {
  const MapTile({
    super.key,
    required this.keyName,
    required this.items,
    this.expanded = false,
    required this.depth,
  });
  final String keyName;
  final List<MapEntry> items;
  final bool expanded;
  final int depth;

  @override
  State<MapTile> createState() => _MapTileState();
}

class _MapTileState extends State<MapTile> {
  bool _init = false;
  bool _expanded = false;

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

  // safe call context in build
  _initExpanded(BuildContext context) {
    if (!_init) {
      _init = true;
      final jsonConfig = JsonConfig.of(context);
      _expanded = jsonConfig.style?.openAtStart ?? false;
      int depth = jsonConfig.style?.depth ?? 0;
      if (depth > 0) {
        _expanded = depth > widget.depth;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jsonConfig = JsonConfig.of(context);
    _initExpanded(context);
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
