import 'package:flutter/widgets.dart';
import 'package:json_view/src/widgets/list_tile.dart';
import 'package:json_view/src/widgets/map_tile.dart';
import 'package:json_view/src/widgets/simple_tiles.dart';

class JsonView extends StatelessWidget {
  final dynamic json;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  const JsonView({
    Key? key,
    required this.json,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (json is Map) {
      final items = (json as Map).entries.toList();
      return ListView.builder(
        shrinkWrap: shrinkWrap,
        padding: padding,
        physics: physics,
        itemBuilder: (context, index) {
          final item = items[index];
          final key = item.key;
          return getParsedItem(key, item.value);
        },
        itemCount: items.length,
      );
    } else if (json is List) {
      final items = json as List;
      return ListView.builder(
        shrinkWrap: shrinkWrap,
        padding: padding,
        physics: physics,
        itemBuilder: (context, index) {
          final item = items[index];
          return getIndexedItem(index, item);
        },
        itemCount: items.length,
      );
    }
    return Text('unsupport type');
  }
}

class JsonMapBody extends StatelessWidget {
  final List<MapEntry> items;

  /// use with caution, it will cause performance issue when json root items is too large
  const JsonMapBody({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO
    return Column(
      children: [],
    );
  }
}

Widget getParsedItem(String key, dynamic value) {
  if (value == null) return NullTile(keyName: key);
  if (value is num) return NumTile(keyName: key, value: value);
  if (value is bool) return BoolTile(keyName: key, value: value);
  if (value is String) return StringTile(keyName: key, value: value);
  if (value is List)
    return ListTile(
      keyName: key,
      items: value,
      range: IndexRange(start: 0, end: value.length - 1),
    );
  if (value is Map) return MapTile(keyName: key, items: value.entries.toList());
  return Text('unsupport type');
}

Widget getIndexedItem(int index, dynamic value) {
  return getParsedItem('[$index]', value);
}
