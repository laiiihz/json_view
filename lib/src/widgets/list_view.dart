part of '../json_view.dart';

class _ListView extends StatefulWidget {
  final List json;
  const _ListView({Key? key, required this.json}) : super(key: key);

  @override
  State<_ListView> createState() => __ListViewState();
}

class __ListViewState extends State<_ListView> {
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
      itemCount: widget.json.length,
      itemBuilder: (context, index) {
        final item = widget.json[index];
        if (item is bool) {
          return BooleanBlock(keyValue: '[$index]', value: item);
        }
        if (item is String) {
          return StringBlock(keyValue: '[$index]', value: item);
        }
        if (item is num) {
          return NumBlock(keyValue: '[$index]', value: item);
        }
        if (item is Map<String, dynamic>) {
          return BlockWrapper(
            keyValue: '[$index]',
            child: _MapView(json: item),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
