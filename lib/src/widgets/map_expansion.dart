import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'package:json_view/src/json_widgets.dart';

class MapExpansion extends StatefulWidget {
  final JsonNode node;
  MapExpansion({Key? key, required this.node}) : super(key: key);

  @override
  State<MapExpansion> createState() => _MapExpansionState();
}

class _MapExpansionState extends State<MapExpansion> {
  bool _expansion = false;
  bool get isEmpty => widget.node.children.isEmpty;
  @override
  Widget build(BuildContext context) {
    final scheme = JsonViewConfiguration.of(context).colorScheme;
    Widget child = const SizedBox.shrink();
    Widget valueText = const SizedBox.shrink();
    if (_expansion) {
      child = Column(
        children: widget.node.children.map((e) => JsonWidget(node: e)).toList(),
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    }
    if (!_expansion) {
      valueText = Text('{...}', style: TextStyle(color: scheme.stringColor));
    }

    if (isEmpty) {
      valueText = Text('{}', style: TextStyle(color: scheme.stringColor));
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
