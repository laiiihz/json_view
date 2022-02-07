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
      return ListView.builder(
        itemBuilder: (context, index) {
          return _ListSingle(json: widget.json[index]);
        },
        itemCount: widget.json.length,
      );
    }
    if (widget.json.length <= _maxSize) {
      return _ListSingle(json: widget.json);
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
  const _ListSingle({Key? key, required this.json, this.startIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
      itemCount: json.length,
      itemBuilder: (context, index) {
        final item = json[index];
        final current = index + startIndex;
        if (item is bool || item is String || item is num || item == null) {
          return JsonTile(title: '[$current]', value: item);
        }

        if (item is Map<dynamic, dynamic>) {
          return BlockWrapper(
            keyValue: '[$current]',
            child: _MapView(json: item, mode: _ViewMode.column),
            short: '',
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
