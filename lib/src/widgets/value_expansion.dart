import 'package:flutter/material.dart';
import 'package:json_view/src/ast/json_ast.dart';
import 'package:json_view/src/configuration.dart';
import 'package:json_view/src/util/text_util.dart';

const _kForceEdge = 8.0;

class ValueExpansion<K> extends StatefulWidget {
  final JsonNode<dynamic, K> node;
  ValueExpansion({Key? key, required this.node}) : super(key: key);

  @override
  State<ValueExpansion> createState() => _ValueExpansionState();
}

class _ValueExpansionState extends State<ValueExpansion> {
  bool _expansion = false;

  @override
  Widget build(BuildContext context) {
    final scheme = JsonViewConfiguration.of(context).colorScheme;
    final color = scheme.getByType(widget.node.valueType);

    final displayValue = widget.node.displayValue;
    final keySpan = TextSpan(
        text: widget.node.displayKey, style: TextStyle(color: scheme.keyColor));
    final colonSpan = TextSpan(text: ':');
    final displaySpan = TextSpan(
      text: displayValue,
      style: TextStyle(color: color),
    );

    final keyTextWidth = getTextSize(keySpan).width;
    final colonTextWidth = getTextSize(colonSpan).width;
    final valueTextWidth = getTextSize(displaySpan).width;

    final canRenderWidth = MediaQuery.of(context).size.width -
        widget.node.deep * 8 -
        keyTextWidth -
        colonTextWidth;
    if (valueTextWidth <= canRenderWidth) {
      _expansion = true;
    }

    Widget miniChild = Text.rich(
      TextSpan(children: [
        keySpan,
        colonSpan,
        displaySpan,
      ]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    miniChild = InkWell(
      onTap: () {
        setState(() {
          _expansion = true;
        });
      },
      borderRadius: BorderRadius.circular(4),
      child: miniChild,
    );

    Widget fullChild = SelectableText.rich(
      TextSpan(
        children: [
          keySpan,
          colonSpan,
          displaySpan,
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(left: widget.node.deep * 8 + _kForceEdge),
      child: _expansion ? fullChild : miniChild,
    );
  }
}
