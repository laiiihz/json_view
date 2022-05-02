import 'package:flutter/material.dart';

import '../color_schemes/default_color_scheme.dart';

class JsonConfig extends InheritedWidget {
  /// color scheme of json view
  final JsonColorScheme? color;

  /// item padding
  final EdgeInsetsGeometry? itemPadding;

  /// configuration of json view
  const JsonConfig({
    Key? key,
    Widget? child,
    this.color,
    this.itemPadding,
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
      );
    } else {
      JsonConfig chain = current;
      if (current.color == null) {
        chain = chain.copyWith(color: defaultColor(context));
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

  /// copy with
  JsonConfig copyWith({
    JsonColorScheme? color,
    Widget? child,
    EdgeInsetsGeometry? itemPadding,
  }) {
    return JsonConfig(
      child: child ?? this.child,
      color: color ?? this.color,
      itemPadding: itemPadding ?? this.itemPadding,
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

  /// Json color scheme
  const JsonColorScheme({
    required this.nullColor,
    required this.boolColor,
    required this.numColor,
    required this.stringColor,
    required this.normalColor,
    required this.markColor,
  });
}
