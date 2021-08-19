import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_tile.dart';

class JsonInnerView extends StatelessWidget {
  final Map<String, dynamic> json;
  final String name;
  const JsonInnerView({Key? key, required this.json, required this.name})
      : super(key: key);

  List<MapEntry> get items => json.entries.toList();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final item = items[index];
          return JsonTile(item.key, item.value);
        },
        itemCount: items.length,
      ),
    );
  }
}
