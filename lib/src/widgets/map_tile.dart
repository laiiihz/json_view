import 'package:flutter/material.dart';

import '../models/json_config_data.dart';
import 'arrow_widget.dart';
import 'json_config.dart';
import 'json_view.dart';
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
    final jsonConfig = JsonConfig.of(context);
    Widget result = Column(
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
                  key: item.key,
                  value: item.value,
                  arrow: widget.arrow,
                  openAtStart: widget.expanded,
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
