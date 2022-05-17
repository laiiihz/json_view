import 'package:flutter/material.dart';

import '../models/json_color_scheme.dart';
import '../models/json_style_scheme.dart';
import '../painters/value_background_painter.dart';
import 'json_config.dart';

typedef SpanBuilder = InlineSpan Function(BuildContext context, dynamic value);

class _ColonSpan extends TextSpan {
  const _ColonSpan({
    TextStyle? style,
  }) : super(text: ' : ', style: style);
}

class _KeySpan extends TextSpan {
  final String keyValue;
  const _KeySpan({
    required this.keyValue,
    TextStyle? style,
  }) : super(text: keyValue, style: style);
}

class _ValueSpan extends TextSpan {
  final String value;
  const _ValueSpan({
    required this.value,
    TextStyle? style,
  }) : super(text: value, style: style);
}

class KeyValueTile extends StatelessWidget {
  final String keyName;
  final String value;
  final Widget? leading;
  final VoidCallback? onTap;

  final SpanBuilder? valueBuilder;
  const KeyValueTile({
    Key? key,
    required this.keyName,
    required this.value,
    this.valueBuilder,
    this.leading,
    this.onTap,
  }) : super(key: key);

  JsonColorScheme colorScheme(BuildContext context) =>
      JsonConfig.of(context).color!;

  JsonStyleScheme styleScheme(BuildContext context) =>
      JsonConfig.of(context).style!;

  Color valueColor(BuildContext context) =>
      colorScheme(context).normalColor ?? Colors.black;

  @override
  Widget build(BuildContext context) {
    // cs stand for colorScheme
    final cs = colorScheme(context);
    // ss stand for styleScheme
    final ss = styleScheme(context);
    final spans = <InlineSpan>[
      _KeySpan(
        keyValue: ss.quotation == null
            ? keyName
            : '${ss.quotation!.leftQuote}$keyName${ss.quotation!.rightQuote}',
        style: ss.keysStyle ??
            const TextStyle().copyWith(color: cs.normalColor ?? Colors.grey),
      ),
      _ColonSpan(
        style: ss.keysStyle ??
            const TextStyle().copyWith(color: cs.markColor ?? Colors.white70),
      ),
      valueBuilder == null
          ? _ValueSpan(
              value: value,
              style: ss.valuesStyle?.copyWith(color: valueColor(context)),
            )
          : valueBuilder!(context, value),
    ];

    Widget result = SelectableText.rich(
      TextSpan(children: spans),
      onTap: onTap,
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

class NullTile extends KeyValueTile {
  NullTile({
    Key? key,
    required String keyName,
  }) : super(
          key: key,
          keyName: keyName,
          value: 'null',
          valueBuilder: (context, value) {
            final config = JsonConfig.of(context);
            final color = config.color?.nullBackground;
            TextStyle style = const TextStyle();
            if (config.style?.valuesStyle != null) {
              style = config.style!.valuesStyle!;
            }
            style =
                style.copyWith(color: config.color?.normalColor ?? Colors.grey);
            if (color == null) {
              return _ValueSpan(value: value, style: style);
            }

            return WidgetSpan(
              child: CustomPaint(
                painter: ValueBackgroundPainter(
                  color: color,
                  radius: const Radius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(value, style: style),
                ),
              ),
            );
          },
        );

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).nullColor ?? Colors.teal;
}

class NumTile extends KeyValueTile {
  const NumTile({
    Key? key,
    required String keyName,
    required num value,
  }) : super(
          key: key,
          keyName: keyName,
          value: '$value',
        );

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).numColor ?? Colors.green;
}

class BoolTile extends KeyValueTile {
  const BoolTile({
    Key? key,
    required String keyName,
    required bool value,
  }) : super(
          key: key,
          keyName: keyName,
          value: '$value',
        );

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).boolColor ?? Colors.blue;
}

class StringTile extends KeyValueTile {
  const StringTile({
    Key? key,
    required String keyName,
    required String value,
  }) : super(
          key: key,
          keyName: keyName,
          value: '"$value"',
        );

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).stringColor ?? Colors.orange;
}
