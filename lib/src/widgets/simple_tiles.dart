import 'package:flutter/material.dart';

import 'json_config.dart';

class _ColonSpan extends TextSpan {
  final TextStyle? style;
  _ColonSpan({this.style}) : super(text: ':', style: style);
}

class _KeySpan extends TextSpan {
  final String key;
  final TextStyle? style;
  _KeySpan({required this.key, this.style}) : super(text: key, style: style);
}

class _ValueSpan extends TextSpan {
  final String value;
  final TextStyle? style;
  _ValueSpan({required this.value, this.style})
      : super(text: value, style: style);
}

class KeyValueTile extends StatelessWidget {
  final String keyName;
  final String value;
  final Widget? leading;
  final VoidCallback? onTap;
  final Widget valueWidget;
  const KeyValueTile(
      {Key? key,
      required this.keyName,
      required this.value,
      this.valueWidget = const SizedBox(),
      this.leading,
      this.onTap})
      : super(key: key);

  JsonColorScheme colorScheme(BuildContext context) =>
      JsonConfig.of(context).color!;

  JsonStyleScheme styleScheme(BuildContext context) =>
      JsonConfig.of(context).styles!;

  Color valueColor(BuildContext context) => colorScheme(context).normalColor;

  TextStyle valueStyle(BuildContext context) =>
      styleScheme(context).valuesStyle;

  @override
  Widget build(BuildContext context) {
    // cs stand for colorScheme
    final cs = colorScheme(context);
    // cs stand for styleScheme
    final ss = styleScheme(context);
    final spans = <InlineSpan>[
      _KeySpan(
          key: ss.addDoubleQuotation ? '"$keyName" ' : '$keyName ',
          style: ss.keysStyle.copyWith(color: cs.normalColor)),
      _ColonSpan(style: ss.keysStyle.copyWith(color: cs.markColor)),
      _ValueSpan(
        value: ' $value',
        style: ss.valuesStyle.copyWith(color: valueColor(context)),
      ),
    ];

    final text = SelectableText.rich(
      TextSpan(children: spans),
      onTap: onTap,
    );
    if (leading == null) {
      return Padding(padding: EdgeInsets.only(left: 8), child: text);
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(child: leading),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text,
                  valueWidget,
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}

class NullTile extends KeyValueTile {
  final String keyName;
  const NullTile({Key? key, required this.keyName})
      : super(key: key, keyName: keyName, value: 'null');

  @override
  Color valueColor(BuildContext context) => colorScheme(context).nullColor;
}

class NumTile extends KeyValueTile {
  NumTile({required String keyName, required num value})
      : super(keyName: keyName, value: '$value');

  @override
  Color valueColor(BuildContext context) => colorScheme(context).numColor;
}

class BoolTile extends KeyValueTile {
  BoolTile({required String keyName, required bool value})
      : super(keyName: keyName, value: '$value');

  @override
  Color valueColor(BuildContext context) => colorScheme(context).boolColor;
}

class StringTile extends KeyValueTile {
  StringTile({required String keyName, required String value})
      : super(keyName: keyName, value: '"$value"');

  @override
  Color valueColor(BuildContext context) => colorScheme(context).stringColor;
}
