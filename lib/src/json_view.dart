import 'package:flutter/material.dart';
import 'package:json_view/src/ast/json_ast.dart';
import 'package:json_view/src/json_widgets.dart';

class JsonView extends StatefulWidget {
  final dynamic json;
  JsonView({Key? key, required this.json}) : super(key: key);

  @override
  State<JsonView> createState() => _JsonViewState();
}

class _JsonViewState extends State<JsonView> {
  List<JsonNode> _nodes = [];
  @override
  void initState() {
    super.initState();
    _nodes = compile(widget.json);
  }

  @override
  void didUpdateWidget(JsonView oldWidget) {
    _nodes = compile(widget.json);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = _nodes[index];
        return JsonWidget(node: item);
      },
      itemCount: _nodes.length,
    );
  }
}
