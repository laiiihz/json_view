import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/simple_tiles.dart';

import '../../json_view.dart';

class StringTile extends StatefulWidget {
  final String keyName;
  final String value;
  final bool expanded;
  const StringTile(
      {Key? key,
      required this.keyName,
      required this.value,
      required this.expanded})
      : super(key: key);

  @override
  State<StringTile> createState() => _StringTileState();
}

class _StringTileState extends State<StringTile> {
  late bool expanded = widget.expanded;

  String getParsedKeyName(BuildContext context) {
    final quotation =
        JsonConfig.of(context).style?.quotation ?? const JsonQuotation();
    if (quotation.isEmpty) return widget.keyName;
    return '${quotation.leftQuote}${widget.keyName}${quotation.rightQuote}';
  }

  @override
  Widget build(BuildContext context) {
    final config = JsonConfig.of(context);
    return LayoutBuilder(
      builder: (context, box) {
        /**
         *  [KEY_PREFIX]  [COLON]     [VALUE]
         *  [computed]    [computed]  [computed] 
         */
        double boxWidth = box.maxWidth;

        final text = TextSpan(
          children: [
            KeySpan(
              keyValue: getParsedKeyName(context),
              style: config.style?.keysStyle,
            ),
            const ColonSpan(),
            ValueSpan(
              value: '"${widget.value}"',
              style: config.style?.valuesStyle,
            ),
          ],
        );
        final painter = TextPainter(
          text: text,
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(minWidth: 0, maxWidth: double.infinity);
        final realRenderWidth = painter.width;

        Widget selectedResult = _StringInnterTile(
          keyName: widget.keyName,
          value: widget.value,
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
        );

        if (realRenderWidth > boxWidth) {
          Widget result = _StringOnlyDisplayTile(
            keyName: widget.keyName,
            value: widget.value,
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
          );
          if (expanded) {
            result = selectedResult;
          }
          if (config.animation ?? JsonConfigData.kUseAnimation) {
            result = AnimatedSize(
              alignment: Alignment.topCenter,
              duration: JsonConfig.of(context).animationDuration ??
                  const Duration(milliseconds: 300),
              curve: JsonConfig.of(context).animationCurve ?? Curves.ease,
              child: result,
            );
          }

          return result;
        } else {
          return selectedResult;
        }
      },
    );
  }
}

class _StringInnterTile extends KeyValueTile {
  const _StringInnterTile(
      {required String keyName,
      required String value,
      int? maxLines,
      VoidCallback? onTap})
      : super(
            keyName: keyName,
            value: '"$value"',
            maxLines: maxLines,
            onTap: onTap);

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).stringColor ?? Colors.orange;
}

class _StringOnlyDisplayTile extends _StringInnterTile {
  const _StringOnlyDisplayTile(
      {required String keyName, required String value, VoidCallback? onTap})
      : super(keyName: keyName, value: value, maxLines: 1, onTap: onTap);
  @override
  Widget build(BuildContext context) {
    final cs = colorScheme(context);
    final spans = <InlineSpan>[
      KeySpan(
        keyValue: parsedKeyName(context),
        style: keyStyle(context).copyWith(color: cs.normalColor ?? Colors.grey),
      ),
      ColonSpan(
        style:
            keyStyle(context).copyWith(color: cs.markColor ?? Colors.white70),
      ),
      buildValue(context),
    ];

    Widget result = Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );

    result = GestureDetector(onTap: onTap, child: result);
    result = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: result,
    );

    if (leading == null) {
      result = Padding(padding: const EdgeInsets.only(left: 16), child: result);
    } else {
      result = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(child: leading),
          Expanded(child: result),
        ],
      );
    }

    return result;
  }
}
