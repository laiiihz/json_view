import 'package:flutter/material.dart';

class _ColonSpan extends TextSpan {
  _ColonSpan() : super(text: ':');
}

class _KeySpan extends TextSpan {
  final String key;
  _KeySpan({required this.key}) : super(text: key);
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

  @override
  Widget build(BuildContext context) {
    final spans = <InlineSpan>[
      _KeySpan(key: keyName),
      _ColonSpan(),
      _ValueSpan(value: value),
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
}

class NumTile extends KeyValueTile {
  NumTile({required String keyName, required num value})
      : super(keyName: keyName, value: '$value');
}

class BoolTile extends KeyValueTile {
  BoolTile({required String keyName, required bool value})
      : super(keyName: keyName, value: '$value');
}

class StringTile extends KeyValueTile {
  StringTile({required String keyName, required String value})
      : super(keyName: keyName, value: '"$value"');
}
