import 'package:flutter/material.dart';

class JsonStyleScheme {
  /// text style for keys
  final TextStyle keysStyle;

  /// text style for values
  final TextStyle valuesStyle;

  /// add double quotation on keys or not. default set to false
  final String? quotation;

  /// Json color scheme
  const JsonStyleScheme({
    this.keysStyle = const TextStyle(),
    this.valuesStyle = const TextStyle(),
    this.quotation,
  });

  JsonStyleScheme copyWith({
    TextStyle? keysStyle,
    TextStyle? valuesStyle,
    String? quotation,
  }) {
    return JsonStyleScheme(
      keysStyle: keysStyle ?? this.keysStyle,
      valuesStyle: valuesStyle ?? this.valuesStyle,
      quotation: quotation ?? this.quotation,
    );
  }

  JsonStyleScheme merge(JsonStyleScheme? scheme) {
    if (scheme == null) return this;
    return copyWith(
      keysStyle: scheme.keysStyle,
      valuesStyle: scheme.valuesStyle,
      quotation: scheme.quotation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonStyleScheme &&
        other.keysStyle == keysStyle &&
        other.valuesStyle == valuesStyle &&
        other.quotation == quotation;
  }

  @override
  int get hashCode => hashValues(keysStyle, valuesStyle, quotation);
}
