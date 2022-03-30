import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'package:json_view/src/widgets/list_expansion.dart';
import 'package:json_view/src/widgets/map_expansion.dart';
import 'package:json_view/src/widgets/value_expansion.dart';

class JsonWidget extends StatelessWidget {
  final JsonNode node;
  const JsonWidget({Key? key, required this.node}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (node.type == JsonType.value) {
      return ValueExpansion(node: node);
    }

    if (node.type == JsonType.map) {
      return MapExpansion(node: node);
    }

    if (node.type == JsonType.list) {
      return ListExpansion(node: node);
    }

    return Text('unknow type');
  }
}
