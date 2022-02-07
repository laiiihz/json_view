part of '../json_view.dart';

class _MapView extends StatefulWidget {
  final Map<String, dynamic> json;
  const _MapView({Key? key, required this.json}) : super(key: key);

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        final item = widget.json.entries.toList()[index];
        if (item.value is bool) {
          return BooleanBlock(keyValue: item.key, value: item.value);
        }
        if (item.value is String) {
          return StringBlock(keyValue: item.key, value: item.value);
        }
        if (item.value is num) {
          return NumBlock(keyValue: item.key, value: item.value);
        }
        if (item.value is List) {
          return BlockWrapper(
            keyValue: item.key,
            child: _ListView(json: item.value),
          );
        }
        if (item.value is Map) {
          return BlockWrapper(
            keyValue: item.key,
            child: _MapView(json: item.value),
          );
        }
        return SizedBox.shrink();
      },
      itemCount: widget.json.keys.length,
    );
  }
}
