import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/block_wrapper.dart';
import 'package:json_view/src/widgets/column_builder.dart';

part './widgets/map_view.dart';
part './widgets/list_view.dart';
part 'widgets/blocks.dart';

class JsonView extends StatefulWidget {
  final dynamic json;
  JsonView({Key? key, required this.json})
      : assert(json is Map || json is List),
        super(key: key);

  @override
  State<JsonView> createState() => _JsonViewState();
}

class _JsonViewState extends State<JsonView> {
  @override
  Widget build(BuildContext context) {
    Widget _child = SizedBox.shrink();
    if (widget.json is Map) _child = _MapView(json: widget.json);
    if (widget.json is List) _child = _ListView(json: widget.json);
    return SingleChildScrollView(child: _child);
  }
}
