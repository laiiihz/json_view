import 'package:flutter/material.dart';

import '../models/json_color_scheme.dart';
import '../models/json_style_scheme.dart';
import 'json_config.dart';

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
  final bool isNullValue;
  const KeyValueTile({
    Key? key,
    required this.keyName,
    required this.value,
    this.isNullValue = false,
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
          style: ss.keysStyle?.copyWith(color: cs.normalColor)),
      _ColonSpan(style: ss.keysStyle?.copyWith(color: cs.markColor)),
      isNullValue
          ? WidgetSpan(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: cs.nullBackground,
                ),
                child: Text(
                  value,
                  style: ss.valuesStyle?.copyWith(color: valueColor(context)),
                ),
              ),
            )
          : _ValueSpan(
              value: value,
              style: ss.valuesStyle?.copyWith(color: valueColor(context)),
            ),
    ];

    final text = SelectableText.rich(
      TextSpan(children: spans),
      onTap: onTap,
    );
    if (leading == null) {
      return Padding(padding: const EdgeInsets.only(left: 16), child: text);
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(child: leading),
          Expanded(child: text),
        ],
      );
    }
  }
}

class NullTile extends KeyValueTile {
  const NullTile({
    Key? key,
    required String keyName,
  }) : super(
          key: key,
          keyName: keyName,
          value: ' null ',
          isNullValue: true,
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
