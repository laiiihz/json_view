import 'package:flutter/material.dart';

/// Json Color Scheme
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

  final Color? nullBackground;

  /// Json color scheme
  const JsonColorScheme({
    this.nullColor,
    this.boolColor,
    this.numColor,
    this.stringColor,
    this.normalColor,
    this.markColor,
    this.nullBackground,
  });

  /// copy colors from another scheme
  JsonColorScheme copyWith({
    Color? nullColor,
    Color? boolColor,
    Color? numColor,
    Color? stringColor,
    Color? normalColor,
    Color? markColor,
    Color? nullBackground,
  }) {
    return JsonColorScheme(
      nullColor: nullColor ?? this.nullColor,
      boolColor: boolColor ?? this.boolColor,
      numColor: numColor ?? this.numColor,
      stringColor: stringColor ?? this.stringColor,
      normalColor: normalColor ?? this.normalColor,
      markColor: markColor ?? this.markColor,
      nullBackground: nullBackground ?? this.nullBackground,
    );
  }

  /// merge colors from another scheme
  JsonColorScheme merge(JsonColorScheme? scheme) {
    if (scheme == null) return this;
    return copyWith(
      nullColor: scheme.nullColor,
      boolColor: scheme.boolColor,
      numColor: scheme.numColor,
      stringColor: scheme.stringColor,
      normalColor: scheme.normalColor,
      markColor: scheme.markColor,
      nullBackground: scheme.nullBackground,
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
        other.markColor == markColor &&
        other.nullBackground == nullBackground;
  }

  @override
  int get hashCode => hashValues(
        nullColor,
        boolColor,
        numColor,
        stringColor,
        normalColor,
        markColor,
        nullBackground,
      );
}

/// default light color scheme
const defaultLightColorScheme = JsonColorScheme(
  nullColor: Colors.teal,
  boolColor: Colors.blue,
  numColor: Colors.green,
  stringColor: Colors.orange,
  normalColor: Colors.grey,
  markColor: Colors.black87,
);

/// default dark color scheme
final defaultDarkColorScheme = JsonColorScheme(
  nullColor: Colors.teal[200]!,
  boolColor: Colors.blue[200]!,
  numColor: Colors.green[200]!,
  stringColor: Colors.orange[200]!,
  normalColor: Colors.grey,
  markColor: Colors.white70,
);
