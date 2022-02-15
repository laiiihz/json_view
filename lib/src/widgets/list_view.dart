part of '../json_view.dart';

class _ListView extends StatefulWidget {
  final List json;
  final _ViewMode mode;
  const _ListView({Key? key, required this.json, required this.mode})
      : super(key: key);

  @override
  State<_ListView> createState() => __ListViewState();
}

class __ListViewState extends State<_ListView> {
  static const _maxSize = 50;
  @override
  Widget build(BuildContext context) {
    if (_ViewMode.list == widget.mode) {
      return _ListSingle(json: widget.json, mode: _ViewMode.list);
    } else if (widget.json.length <= _maxSize) {
      return _ListSingle(json: widget.json, mode: _ViewMode.column);
    } else {
      List<List> items = [];
      int maxLength = (widget.json.length / _maxSize).ceil();
      for (var i = 0; i < maxLength; i++) {
        int start = 0 + _maxSize * i;
        int end = (_maxSize + _maxSize * i) > widget.json.length
            ? widget.json.length
            : _maxSize + _maxSize * i;
        items.add(widget.json.sublist(start, end));
      }
      return ColumnBuilder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          int start = 0 + _maxSize * index;
          int end = start + _maxSize;
          if (index >= (maxLength - 1)) {
            end = widget.json.length;
          }
          return BlockWrapper(
            keyValue: '[$start ~ $end]',
            child: _ListSingle(
              json: items[index],
              startIndex: start,
              mode: _ViewMode.column,
            ),
            short: '',
          );
        },
      );
    }
  }
}

class _ListSingle extends StatelessWidget {
  final List json;
  final int startIndex;
  final _ViewMode mode;
  const _ListSingle(
      {Key? key, required this.json, this.startIndex = 0, required this.mode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IndexedWidgetBuilder indexedWidgetBuilder = (context, index) {
      final item = json[index];
      final current = index + startIndex;
      if (item is bool || item is String || item is num || item == null) {
        return JsonTile(title: '[$current]', value: item);
      }

      if (item is Map<dynamic, dynamic>) {
        return BlockWrapper(
          keyValue: '[$current]',
          child: _MapView(json: item, mode: _ViewMode.column),
          short: 'Map',
        );
      }
      if (item is List) {
        return BlockWrapper(
          keyValue: '[$current]',
          child: _ListView(json: item, mode: _ViewMode.column),
          short: 'List',
        );
      }
      return SizedBox.shrink();
    };
    if (_ViewMode.column == mode) {
      return ColumnBuilder(
        itemCount: json.length,
        itemBuilder: indexedWidgetBuilder,
      );
    }
    if (_ViewMode.list == mode) {
      return ListView.builder(
        itemCount: json.length,
        itemBuilder: indexedWidgetBuilder,
      );
    }
    return SizedBox.shrink();
  }
}
