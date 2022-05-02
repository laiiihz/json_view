import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_config.dart';

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
  const KeyValueTile(
      {Key? key,
      required this.keyName,
      required this.value,
      this.leading,
      this.onTap})
      : super(key: key);

  JsonColorScheme colorScheme(BuildContext context) =>
      JsonConfig.of(context).color!;

  Color valueColor(BuildContext context) => colorScheme(context).normalColor;

  @override
  Widget build(BuildContext context) {
    // cs stand for colorScheme
    final cs = colorScheme(context);
    final spans = <InlineSpan>[
      _KeySpan(key: keyName, style: TextStyle(color: cs.normalColor)),
      _ColonSpan(style: TextStyle(color: cs.markColor)),
      _ValueSpan(value: value, style: TextStyle(color: valueColor(context))),
    ];

    final text = SelectableText.rich(
      TextSpan(children: spans),
      onTap: onTap,
    );
    if (leading == null) {
      return Padding(padding: EdgeInsets.only(left: 8), child: text);
    } else {
      return Row(
        children: [
          SizedBox(width: 8, child: leading),
          Expanded(child: text),
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
