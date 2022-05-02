import 'package:flutter/material.dart';

import 'package:json_view/json_view.dart';
import 'package:json_view/src/widgets/arrow_widget.dart';
import 'package:json_view/src/widgets/simple_tiles.dart';

class IndexRange {
  final int start;
  final int end;
  IndexRange({
    required this.start,
    required this.end,
  });

  int get length => end - start;
}

class ListTile extends StatefulWidget {
  final String keyName;
  final List items;
  final IndexRange range;

  ListTile(
      {Key? key,
      required this.keyName,
      required this.items,
      required this.range})
      : super(key: key);

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  bool _expanded = false;

  String get _value {
    if (widget.items.isEmpty) return '[]';
    if (_expanded) return '';
    if (widget.items.length == 1) return '[0]';
    if (widget.items.length == 2) return '[0,1]';
    return '[${widget.range.start}...${widget.range.end}]';
  }

  void changeState() {
    if (widget.items.isNotEmpty)
      setState(() {
        _expanded = !_expanded;
      });
  }

  List<Widget> get _children {
    if (widget.items.isEmpty) return [];

    //GAP 100
    if (widget.range.length < 100) {
      final result = <Widget>[];
      for (var i = 0; i <= widget.range.length; i++) {
        result.add(getIndexedItem(i, widget.items[i]));
      }
      return result;
    }
    return _gapChildren();
  }

  List<Widget> _gapChildren() {
    int gap = 100;
    while (widget.range.length / gap > 100) {
      gap *= 100;
    }
    int divide = widget.range.length ~/ gap;
    int dividedLength = gap * divide;
    late int gapSize;
    if (dividedLength == widget.items.length) {
      gapSize = divide;
    } else {
      gapSize = divide + 1;
    }
    final _result = <Widget>[];
    for (var i = 0; i < gapSize; i++) {
      int startIndex = widget.range.start + i * gap;
      int endIndex = widget.range.end;
      if (i != gapSize - 1) {
        _result.add(
          ListTile(
            keyName: '[$i]',
            items: widget.items,
            range: IndexRange(start: startIndex, end: startIndex + gap - 1),
          ),
        );
      } else {
        _result.add(
          ListTile(
            keyName: '[$i]',
            items: widget.items,
            range: IndexRange(start: startIndex, end: endIndex),
          ),
        );
      }
    }
    return _result;
  }

  @override
  Widget build(BuildContext context) {
    final jsonConfig = JsonConfig.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KeyValueTile(
          keyName: widget.keyName,
          value: _value,
          onTap: changeState,
          leading: widget.items.isEmpty
              ? null
              : ArrowWidget(
                  direction:
                      _expanded ? ArrowDirection.down : ArrowDirection.right,
                  onTap: changeState,
                ),
        ),
        if (_expanded)
          Padding(
            padding: jsonConfig.itemPadding!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _children,
            ),
          ),
      ],
    );
  }
}
