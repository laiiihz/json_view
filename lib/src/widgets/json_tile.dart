import 'package:flutter/material.dart';

import '../json_inner_list.dart';
import '../json_inner_view.dart';
import '../json_view.dart';

class JsonTile extends StatelessWidget {
  final String name;
  final dynamic value;
  const JsonTile(
    this.name,
    this.value, {
    Key? key,
  }) : super(key: key);

  String get type {
    if (value is num) return 'Number';
    if (value is bool) return 'Boolean';
    if (value is String) return 'String';
    if (value is Map) return 'Map';
    if (value is List) return 'List';
    if (value == null) return 'null';
    return 'Unknown';
  }

  bool get canTap => value is Map || value is List;

  Color? get color {
    if (value is num) return Colors.blue;
    if (value is bool) return Colors.orange;
    if (value is String) return Colors.grey;
    if (value is Map) return Colors.blueGrey;
    if (value is List) return Colors.blueGrey;
    if (value == null) return Colors.grey;
  }

  String get _hiddenValue {
    final temp = value.toString();
    if (temp.length > 100) return temp.substring(0, 100);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Chip(
        label: Text(type),
        backgroundColor: color?.withOpacity(0.4),
      ),
      onTap: canTap
          ? () {
              JsonView.add(name);
              if (value is Map) {
                JsonView.navigator.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => JsonInnerView(
                      json: value,
                      name: name,
                    ),
                  ),
                );
              }

              if (value is List) {
                JsonView.navigator.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => JsonInnerList(
                      items: value,
                      name: name,
                    ),
                  ),
                );
              }
            }
          : null,
      title: Text(name),
      tileColor: canTap ? Colors.green.withOpacity(0.1) : null,
      subtitle: Text(
        _hiddenValue,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: color),
      ),
    );
  }
}
