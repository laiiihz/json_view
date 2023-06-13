import 'package:flutter/material.dart';

import '../models/json_color_scheme.dart';
import '../models/json_style_scheme.dart';
import '../painters/value_background_painter.dart';
import 'arrow_widget.dart';
import 'json_config.dart';

typedef SpanBuilder = InlineSpan Function(BuildContext context, dynamic value);

class ColonSpan extends TextSpan {
  const ColonSpan({
    super.style,
  }) : super(text: ' : ');
}

class KeySpan extends TextSpan {
  final String keyValue;
  const KeySpan({
    required this.keyValue,
    super.style,
  }) : super(text: keyValue);
}

class ValueSpan extends TextSpan {
  final String value;
  const ValueSpan({
    required this.value,
    super.style,
  }) : super(text: value);
}

class KeyValueTile extends StatelessWidget {
  final String keyName;
  final String value;
  final Widget? leading;
  final VoidCallback? onTap;
  final int? maxLines;
  const KeyValueTile({
    super.key,
    required this.keyName,
    required this.value,
    this.leading,
    this.onTap,
    this.maxLines,
  });

  JsonColorScheme colorScheme(BuildContext context) =>
      JsonConfig.of(context).color ?? const JsonColorScheme();

  JsonStyleScheme styleScheme(BuildContext context) =>
      JsonConfig.of(context).style ?? const JsonStyleScheme();

  Color valueColor(BuildContext context) =>
      colorScheme(context).normalColor ?? Colors.black;

  String parsedKeyName(BuildContext context) {
    final quotation = styleScheme(context).quotation ?? const JsonQuotation();
    if (quotation.isEmpty) return keyName;
    return '${quotation.leftQuote}$keyName${quotation.rightQuote}';
  }

  TextStyle keyStyle(BuildContext context) {
    final ss = styleScheme(context);
    if (ss.keysStyle == null) return const TextStyle();
    return ss.keysStyle!;
  }

  TextStyle valueStyle(BuildContext context) {
    final ss = styleScheme(context);
    if (ss.valuesStyle == null) return const TextStyle();
    return ss.valuesStyle!;
  }

  InlineSpan buildValue(BuildContext context) {
    return ValueSpan(
      value: value,
      style: valueStyle(context).copyWith(color: valueColor(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // cs stand for colorScheme
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

    Widget result = SelectableText.rich(
      TextSpan(children: spans),
      onTap: onTap,
      maxLines: maxLines,
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
  const NullTile({
    super.key,
    required super.keyName,
  }) : super(value: 'null');

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).nullColor ?? Colors.teal;

  @override
  InlineSpan buildValue(BuildContext context) {
    final config = JsonConfig.of(context);
    final color = config.color?.nullBackground;
    TextStyle style = const TextStyle();
    if (config.style?.valuesStyle != null) {
      style = config.style!.valuesStyle!;
    }
    style = style.copyWith(color: valueColor(context));
    if (color == null) {
      return ValueSpan(value: value, style: style);
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
  }
}

class NumTile extends KeyValueTile {
  const NumTile({
    super.key,
    required super.keyName,
    required num value,
  }) : super(value: '$value');

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).numColor ?? Colors.green;
}

class BoolTile extends KeyValueTile {
  const BoolTile({
    super.key,
    required super.keyName,
    required bool value,
  }) : super(value: '$value');

  @override
  Color valueColor(BuildContext context) =>
      colorScheme(context).boolColor ?? Colors.blue;
}

class MapListTile extends KeyValueTile {
  MapListTile({
    super.key,
    required super.keyName,
    required String value,
    required VoidCallback onTap,
    required bool showLeading,
    required bool expanded,
  }) : super(
          value: value,
          onTap: onTap,
          leading: showLeading
              ? ArrowWidget(expanded: expanded, onTap: onTap)
              : null,
        );

  @override
  Color valueColor(BuildContext context) {
    final cs = colorScheme(context);
    return cs.normalColor ?? Colors.black;
  }
}
