import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'package:json_view/src/json_widgets.dart';

class ListExpansion extends StatefulWidget {
  final JsonNode node;
  ListExpansion({Key? key, required this.node}) : super(key: key);

  @override
  State<ListExpansion> createState() => _ListExpansionState();
}

class _ListExpansionState extends State<ListExpansion> {
  bool _expansion = false;

  bool get isEmpty => widget.node.children.isEmpty;

  @override
  Widget build(BuildContext context) {
    final scheme = JsonViewConfiguration.of(context).colorScheme;
    Widget child = const SizedBox.shrink();
    Widget valueText = const SizedBox.shrink();
    if (_expansion) {
      int count = widget.node.children.length ~/ 100 + 1;
      List<Widget> children = [];
      if (count == 1) {
        children =
            widget.node.children.map((e) => JsonWidget(node: e)).toList();
        child = Column(
          children: children,
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      } else {
        for (var i = 0; i < count; i++) {
          final startIndex = 0 + i * 100;
          int endIndex = (i + 1) * 100 - 1;
          if (endIndex > widget.node.children.length) {
            endIndex = widget.node.children.length - 1;
          }
          children.add(_NumberCountWidget(
            startIndex: startIndex,
            endIndex: endIndex,
            children:
                widget.node.children.getRange(startIndex, endIndex).toList(),
            deep: widget.node.deep + 1,
          ));
        }
        child = Column(
          children: children,
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      }
    }

    final length = widget.node.children.length;
    if (isEmpty) {
      valueText = Text('[]');
    } else {
      valueText = Text('[0...${length - 1}]');
    }
    return Stack(
      children: [
        InkWell(
          onTap: isEmpty
              ? null
              : () {
                  setState(() {
                    _expansion = !_expansion;
                  });
                },
          child: SizedBox(
            height: 24,
            child: Row(
              children: [
                SizedBox(width: widget.node.deep * 8),
                isEmpty
                    ? SizedBox(width: 8)
                    : Align(
                        child: RotatedBox(
                          quarterTurns: _expansion ? 0 : -1,
                          child: Icon(Icons.arrow_drop_down, size: 16),
                        ),
                        widthFactor: 0.5,
                      ),
                Text(
                  widget.node.displayKey,
                  style: TextStyle(color: scheme.keyColor),
                ),
                Text(': '),
                valueText,
              ],
            ),
          ),
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.topLeft,
            heightFactor: _expansion ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _NumberCountWidget extends StatefulWidget {
  final int startIndex;
  final int endIndex;
  final int deep;
  final List<JsonNode> children;
  _NumberCountWidget(
      {Key? key,
      required this.startIndex,
      required this.endIndex,
      required this.children,
      required this.deep})
      : super(key: key);

  @override
  State<_NumberCountWidget> createState() => __NumberCountWidgetState();
}

class __NumberCountWidgetState extends State<_NumberCountWidget> {
  bool _expansion = false;
  @override
  Widget build(BuildContext context) {
    final scheme = JsonViewConfiguration.of(context).colorScheme;
    Widget child = const SizedBox.shrink();
    if (_expansion) {
      child = Column(
        children: widget.children.map((e) => JsonWidget(node: e)).toList(),
      );
    }
    return Stack(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expansion = !_expansion;
            });
          },
          child: SizedBox(
            height: 24,
            child: Row(
              children: [
                SizedBox(width: widget.deep * 8),
                Align(
                  child: RotatedBox(
                    quarterTurns: _expansion ? 0 : -1,
                    child: Icon(Icons.arrow_drop_down, size: 16),
                  ),
                  widthFactor: 0.5,
                ),
                Text(
                  '[${widget.startIndex}...${widget.endIndex}]',
                  style: TextStyle(color: scheme.stringColor),
                ),
              ],
            ),
          ),
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.topLeft,
            heightFactor: _expansion ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
