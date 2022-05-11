import 'package:flutter/material.dart';
import 'package:json_view/src/models/json_style_scheme.dart';

import 'json_color_scheme.dart';

class JsonConfigData {
  /// color scheme of json view
  final JsonColorScheme? color;

  final JsonStyleScheme? style;

  /// has animation
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
    this.style,
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
      style: defaultStyle(context),
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

  /// default style scheme
  ///
  // original from #4
  static JsonStyleScheme defaultStyle(BuildContext context) =>
      const JsonStyleScheme(
        keysStyle: TextStyle(),
        valuesStyle: TextStyle(),
        quotation: null,
      );

  JsonConfigData copyWith({
    JsonColorScheme? color,
    JsonStyleScheme? style,
    bool? animation,
    EdgeInsetsGeometry? itemPadding,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return JsonConfigData(
      color: this.color?.merge(color),
      style: this.style?.merge(style),
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
      style: data.style,
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
