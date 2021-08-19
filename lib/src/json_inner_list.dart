import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'package:json_view/src/json_inner_view.dart';
import 'package:json_view/src/widgets/json_tile.dart';

class JsonInnerList extends StatelessWidget {
  final List<dynamic> items;
  final String name;

  const JsonInnerList({Key? key, required this.items, required this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final item = items[index];
          return JsonTile('$name[$index]', item);
        },
        itemCount: items.length,
      ),
    );
  }
}
