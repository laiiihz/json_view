part of '../json_view.dart';

class _MapView extends StatefulWidget {
  final Map<dynamic, dynamic> json;
  final _ViewMode mode;

  const _MapView({Key? key, required this.json, required this.mode})
      : super(key: key);

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    final IndexedWidgetBuilder indexedWidgetBuilder = (context, index) {
      final item = widget.json.entries.toList()[index];
      if (item.value is bool ||
          item.value is String ||
          item.value is num ||
          item.value == null) {
        return JsonTile(title: item.key, value: item.value);
      }
      if (item.value is List) {
        if ((item.value as List).isEmpty) {
          return JsonTile(title: item.key, value: '[]');
        }
        return BlockWrapper(
          keyValue: item.key,
          child: _ListView(json: item.value, mode: _ViewMode.column),
          short: '[0...${item.value.length}]',
        );
      }
      if (item.value is Map) {
        if ((item.value as Map).isEmpty) {
          return JsonTile(title: item.key, value: '{}');
        }
        return BlockWrapper(
          keyValue: item.key,
          child: _MapView(json: item.value, mode: _ViewMode.column),
          short: '{...}',
        );
      }
      return SizedBox.shrink();
    };
    if (widget.mode == _ViewMode.list) {
      return ListView.builder(
        itemBuilder: indexedWidgetBuilder,
        itemCount: widget.json.keys.length,
      );
    } else {
      return ColumnBuilder(
        itemBuilder: indexedWidgetBuilder,
        itemCount: widget.json.keys.length,
      );
    }
  }
}
