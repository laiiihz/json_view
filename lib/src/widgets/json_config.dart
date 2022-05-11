import 'package:flutter/material.dart';

import '../color_schemes/default_color_scheme.dart';

class JsonConfig extends InheritedWidget {
  final JsonConfigData? data;

  /// configuration of json view
  const JsonConfig({
    Key? key,
    Widget? child,
    this.data,
  }) : super(key: key, child: child ?? const SizedBox.shrink());
  @override
  bool updateShouldNotify(JsonConfig oldWidget) => oldWidget.data != data;

  /// get a [JsonConfigData] from [BuildContext]
  static JsonConfigData of(BuildContext context) {
    final current = context.dependOnInheritedWidgetOfExactType<JsonConfig>();
    final fallback = JsonConfigData.fallback(context);
    if (current?.data == null) return fallback;
    return fallback.merge(current!.data);
  }
}

class JsonConfigData {
  /// color scheme of json view
  final JsonColorScheme? color;

  final bool? animation;

  /// item padding,
  /// default is EdgeInsets.only(left: 8)
  final EdgeInsetsGeometry? itemPadding;

  /// default is 300 milliseconds
  ///
  /// only work with [animation] is true
  final Duration? animationDuration;

  /// default is [Curves.ease]
  ///
  /// only work with [animation] is true
  final Curve? animationCurve;

  JsonConfigData({
    this.color,
    this.itemPadding,
    this.animation,
    this.animationDuration,
    this.animationCurve,
  });

  static const kUseAnimation = true;
  static const kItemPadding = EdgeInsets.only(left: 8);
  static const kAnimationDuration = Duration(milliseconds: 300);
  static const kAnimationCurve = Curves.easeInOutCubic;

  factory JsonConfigData.fallback(BuildContext context) {
    return JsonConfigData(
      color: defaultColor(context),
      animation: kUseAnimation,
      itemPadding: kItemPadding,
      animationDuration: kAnimationDuration,
      animationCurve: kAnimationCurve,
    );
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

  JsonConfigData copyWith({
    JsonColorScheme? color,
    bool? animation,
    EdgeInsetsGeometry? itemPadding,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return JsonConfigData(
      color: this.color?.merge(color),
      animation: animation ?? this.animation,
      itemPadding: itemPadding ?? this.itemPadding,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  JsonConfigData merge(JsonConfigData? data) {
    if (data == null) return this;
    return copyWith(
      color: data.color,
      animation: data.animation,
      itemPadding: data.itemPadding,
      animationDuration: data.animationDuration,
      animationCurve: data.animationCurve,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonConfigData &&
        other.color == color &&
        other.itemPadding == itemPadding &&
        other.animation == animation &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve;
  }

  @override
  int get hashCode => hashValues(
        color,
        itemPadding,
        animationDuration,
        animationCurve,
      );
}

class JsonColorScheme {
  /// color for null value
  final Color? nullColor;

  /// color for boolean value
  final Color? boolColor;

  /// color for number value
  final Color? numColor;

  /// color for string value
  final Color? stringColor;

  /// color for normal value like keys
  final Color? normalColor;

  /// color for arrow & other widget
  final Color? markColor;

  /// Json color scheme
  const JsonColorScheme({
    this.nullColor,
    this.boolColor,
    this.numColor,
    this.stringColor,
    this.normalColor,
    this.markColor,
  });

  JsonColorScheme copyWith({
    Color? nullColor,
    Color? boolColor,
    Color? numColor,
    Color? stringColor,
    Color? normalColor,
    Color? markColor,
  }) {
    return JsonColorScheme(
      nullColor: nullColor ?? this.nullColor,
      boolColor: boolColor ?? this.boolColor,
      numColor: numColor ?? this.numColor,
      stringColor: stringColor ?? this.stringColor,
      normalColor: normalColor ?? this.normalColor,
      markColor: markColor ?? this.markColor,
    );
  }

  JsonColorScheme merge(JsonColorScheme? scheme) {
    if (scheme == null) return this;
    return copyWith(
      nullColor: scheme.nullColor,
      boolColor: scheme.boolColor,
      numColor: scheme.numColor,
      stringColor: scheme.stringColor,
      normalColor: scheme.normalColor,
      markColor: scheme.markColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is JsonColorScheme &&
        other.nullColor == nullColor &&
        other.boolColor == boolColor &&
        other.numColor == numColor &&
        other.stringColor == stringColor &&
        other.normalColor == normalColor &&
        other.markColor == markColor;
  }

  @override
  int get hashCode => hashValues(
        nullColor,
        boolColor,
        numColor,
        stringColor,
        normalColor,
        markColor,
      );
}
