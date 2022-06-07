import 'package:flutter/widgets.dart';
import 'package:json_view/src/widgets/json_config.dart';
import 'package:json_view/src/widgets/string_tile.dart';

import '../models/json_color_scheme.dart';
import '../models/json_config_data.dart';
import '../models/json_style_scheme.dart';
import 'list_tile.dart';
import 'map_tile.dart';
import 'simple_tiles.dart';

class JsonView extends StatelessWidget {
  /// {@template json_view.json_view.json}
  /// a json object to be displayed
  ///
  /// normally this is a Map or List
  /// {@endtemplate}
  final dynamic json;

  ///{@macro flutter.widgets.scroll_view.shrinkWrap}
  final bool shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  ///{@macro flutter.widgets.scroll_view.physics}
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scroll_view.controller}
  final ScrollController? controller;

  /// arrow widget
  @Deprecated('use JsonStyleScheme.arrowWidget instead')
  final Widget? arrow;

  final JsonColorScheme? colorScheme;

  final JsonStyleScheme? styleScheme;

  final bool? animation;
  final EdgeInsets? itemPadding;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final int? gap;

  /// provider a json view, build with listview
  ///
  /// see more [JsonConfig] to customize the view
  const JsonView({
    Key? key,
    required this.json,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
    this.controller,
    this.arrow,
    this.colorScheme,
    this.styleScheme,
    this.animation,
    this.itemPadding,
    this.animationDuration,
    this.animationCurve,
    this.gap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (json is! Map && json is! List) {
      return const Text('unsupport type');
    }
    late IndexedWidgetBuilder builder;
    late int count;
    if (json is Map) {
      final items = (json as Map).entries.toList();
      builder = (context, index) {
        final item = items[index];
        final key = item.key;
        return getParsedItem(key: key, value: item.value);
      };
      count = items.length;
    } else if (json is List) {
      final items = json as List;
      builder = (context, index) {
        final item = items[index];
        return getIndexedItem(index: index, value: item);
      };
      count = items.length;
    }
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding,
      physics: physics,
      controller: controller,
      itemBuilder: builder,
      itemCount: count,
    );
  }
}

class JsonViewBody extends StatelessWidget {
  /// use with caution, it will cause performance issue when json root items is too large
  const JsonViewBody(
      {Key? key,
      required this.json,
      this.colorScheme,
      this.styleScheme,
      this.animation,
      this.itemPadding,
      this.animationDuration,
      this.animationCurve,
      this.gap})
      : super(key: key);

  /// {@macro json_view.json_view.json}
  final dynamic json;

  final JsonColorScheme? colorScheme;

  final JsonStyleScheme? styleScheme;

  final bool? animation;
  final EdgeInsets? itemPadding;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final int? gap;

  @override
  Widget build(BuildContext context) {
    if (json is! Map && json is! List) {
      return const Text('unsupport type');
    }
    late List<Widget> items;
    if (json is Map) {
      items = (json as Map).entries.map((entry) {
        final key = entry.key;
        return getParsedItem(key: key, value: entry.value);
      }).toList();
    } else if (json is List) {
      items = (json as List).map((item) {
        return getIndexedItem(index: 0, value: item);
      }).toList();
    }
    return Column(children: items);
  }
}

/// get a tile Widget from value & key
Widget getParsedItem({
  required String key,
  required dynamic value,
}) {
  if (value == null) return NullTile(keyName: key);
  if (value is num) return NumTile(keyName: key, value: value);
  if (value is bool) return BoolTile(keyName: key, value: value);
  if (value is String) {
    return StringTile(
      keyName: key,
      value: value,
    );
  }
  if (value is List) {
    return ListTile(
      keyName: key,
      items: value,
      range: IndexRange(start: 0, end: value.length - 1),
    );
  }
  if (value is Map) {
    return MapTile(
      keyName: key,
      items: value.entries.toList(),
    );
  }
  return const Text('unsupport type');
}

/// get a tile Widget from value & index
Widget getIndexedItem({required int index, required dynamic value}) {
  return getParsedItem(key: '[$index]', value: value);
}
