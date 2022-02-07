import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/block_wrapper.dart';
import 'package:json_view/src/widgets/column_builder.dart';
import 'package:json_view/src/widgets/json_tile.dart';

part './widgets/map_view.dart';
part './widgets/list_view.dart';
part 'widgets/blocks.dart';

enum _ViewMode {
  list,
  column,
}

class JsonView extends StatefulWidget {
  final dynamic json;
  JsonView({Key? key, required this.json})
      : assert(
          json is Map || json is List,
          "not a valid Json map or Json List",
        ),
        super(key: key);

  @override
  State<JsonView> createState() => _JsonViewState();
}

class _JsonViewState extends State<JsonView> {
  @override
  Widget build(BuildContext context) {
    if (widget.json is Map) {
      return _MapView(
        json: widget.json,
        mode: _ViewMode.list,
      );
    }
    if (widget.json is List) {
      return _ListView(json: widget.json, mode: _ViewMode.list);
    }

    return SizedBox.shrink();
  }
}
