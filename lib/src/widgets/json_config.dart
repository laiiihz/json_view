import 'package:flutter/material.dart';

import '../color_schemes/default_color_scheme.dart';

class JsonConfig extends InheritedWidget {
  /// color scheme of json view
  final JsonColorScheme? color;

  /// item padding
  final EdgeInsetsGeometry? itemPadding;

  /// default is 300 milliseconds
  final Duration? customArrowAnimationDuration;

  /// default is [Curves.ease]
  final Curve? customArrowAnimationCurve;

  /// style scheme of json view
  final JsonStyleScheme? styles;

  /// configuration of json view
  const JsonConfig({
    Key? key,
    Widget? child,
    this.color,
    this.itemPadding,
    this.customArrowAnimationCurve,
    this.customArrowAnimationDuration,
    this.styles,
  }) : super(key: key, child: child ?? const SizedBox.shrink());
  @override
  bool updateShouldNotify(JsonConfig oldWidget) => color != oldWidget.color;

  /// get a [JsonConfig] from [BuildContext]
  static JsonConfig of(BuildContext context) {
    final current = context.dependOnInheritedWidgetOfExactType<JsonConfig>();
    if (current == null) {
      return JsonConfig(
        color: defaultColor(context),
        itemPadding: EdgeInsets.only(left: 8),
        styles: defaultStyle(context),
      );
    } else {
      JsonConfig chain = current;
      if (current.color == null) {
        chain = chain.copyWith(color: defaultColor(context));
      }
      if (current.styles == null) {
        chain = chain.copyWith(styles: defaultStyle(context));
      }
      if (current.itemPadding == null) {
        chain = chain.copyWith(itemPadding: EdgeInsets.only(left: 8));
      }
      return chain;
    }
  }

  /// default color scheme
  static JsonColorScheme defaultColor(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      return defaultDarkColorScheme;
    } else {
      return defaultLightColorScheme;
    }
  }

  /// default style scheme
  static JsonStyleScheme defaultStyle(BuildContext context) => JsonStyleScheme(
        keysStyle: TextStyle(),
        valuesStyle: TextStyle(),
      );

  /// copy with
  JsonConfig copyWith({
    JsonColorScheme? color,
    Widget? child,
    EdgeInsetsGeometry? itemPadding,
    JsonStyleScheme? styles,
  }) {
    return JsonConfig(
      child: child ?? this.child,
      color: color ?? this.color,
      itemPadding: itemPadding ?? this.itemPadding,
      styles: styles ?? this.styles,
    );
  }
}

class JsonColorScheme {
  /// color for null value
  final Color nullColor;

  /// color for boolean value
  final Color boolColor;

  /// color for number value
  final Color numColor;

  /// color for string value
  final Color stringColor;

  /// color for normal value like keys
  final Color normalColor;

  /// color for arrow & other widget
  final Color markColor;

  /// color for null background
  final Color nullBackground;

  /// Json color scheme
  const JsonColorScheme({
    this.nullColor = Colors.transparent,
    required this.boolColor,
    required this.numColor,
    required this.stringColor,
    required this.normalColor,
    required this.markColor,
    required this.nullBackground,
  });
}

class JsonStyleScheme {
  /// text style for keys
  final TextStyle keysStyle;

  /// text style for values
  final TextStyle valuesStyle;

  /// add double quotation on keys or not. default set to false
  final bool addDoubleQuotation;

  /// Json color scheme
  const JsonStyleScheme({
    this.keysStyle = const TextStyle(),
    this.valuesStyle = const TextStyle(),
    this.addDoubleQuotation = false,
  });
}
