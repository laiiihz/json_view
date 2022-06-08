import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_view.dart';

import 'json_color_scheme.dart';
import 'json_style_scheme.dart';

/// Json View Configuration Data
class JsonConfigData {
  /// color scheme of json view
  ///
  /// default is defaultDarkColorScheme & defaultLightColorScheme base on current theme
  final JsonColorScheme? color;

  /// the style of json view
  final JsonStyleScheme? style;

  /// has animation
  final bool? animation;

  /// item padding,
  /// default is EdgeInsets.only(left: 8)
  final EdgeInsets? itemPadding;

  /// default is 300 milliseconds
  ///
  /// only work with [animation] is true
  final Duration? animationDuration;

  /// default is [Curves.ease]
  ///
  /// only work with [animation] is true
  final Curve? animationCurve;

  /// json list gap, default is 100
  final int? gap;

  /// Json View Configuration Data
  JsonConfigData({
    this.color,
    this.style,
    this.itemPadding,
    this.animation,
    this.animationDuration,
    this.animationCurve,
    this.gap,
  });

  JsonConfigData.fromJsonView(JsonView view)
      : color = view.colorScheme,
        style = view.styleScheme,
        animation = view.animation,
        itemPadding = view.itemPadding,
        animationDuration = view.animationDuration,
        animationCurve = view.animationCurve,
        gap = null;

  JsonConfigData.fromJsonViewBody(JsonViewBody body)
      : color = body.colorScheme,
        style = body.styleScheme,
        animation = body.animation,
        itemPadding = body.itemPadding,
        animationDuration = body.animationDuration,
        animationCurve = body.animationCurve,
        gap = body.gap;

  /// default use animation
  static const kUseAnimation = true;

  /// default item padding
  static const kItemPadding = EdgeInsets.only(left: 8);

  /// default animation duration
  static const kAnimationDuration = Duration(milliseconds: 300);

  /// default animation curve
  static const kAnimationCurve = Curves.easeInOutCubic;

  static const kGap = 100;

  /// fallback JsonConfigData
  factory JsonConfigData.fallback(BuildContext context) {
    return JsonConfigData(
      color: defaultColor(context),
      style: defaultStyle(context),
      animation: kUseAnimation,
      itemPadding: kItemPadding,
      animationDuration: kAnimationDuration,
      animationCurve: kAnimationCurve,
      gap: kGap,
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
        quotation: JsonQuotation(),
      );

  /// copy another JsonConfigData
  JsonConfigData copyWith({
    JsonColorScheme? color,
    JsonStyleScheme? style,
    bool? animation,
    EdgeInsets? itemPadding,
    Duration? animationDuration,
    Curve? animationCurve,
    int? gap,
  }) {
    final colorScheme = this.color == null ? color : this.color!.merge(color);
    final styleScheme = this.style == null ? style : this.style!.merge(style);
    return JsonConfigData(
      color: colorScheme,
      style: styleScheme,
      animation: animation ?? this.animation,
      itemPadding: itemPadding ?? this.itemPadding,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      gap: gap ?? this.gap,
    );
  }

  /// merge another JsonConfigData
  JsonConfigData merge(JsonConfigData? data) {
    if (data == null) return this;
    return copyWith(
      color: data.color,
      style: data.style,
      animation: data.animation,
      itemPadding: data.itemPadding,
      animationDuration: data.animationDuration,
      animationCurve: data.animationCurve,
      gap: data.gap,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonConfigData &&
        other.color == color &&
        other.style == style &&
        other.itemPadding == itemPadding &&
        other.animation == animation &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve &&
        other.gap == gap;
  }

  @override
  int get hashCode => hashValues(
        color,
        style,
        itemPadding,
        animationDuration,
        animationCurve,
        gap,
      );
}
