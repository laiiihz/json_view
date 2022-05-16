import 'package:flutter/material.dart';

/// JsonQuotation
class JsonQuotation {
  /// left quote
  final String leftQuote;

  /// right quote
  final String rightQuote;

  /// Json Quotation
  ///
  /// [JsonQuotation.arrowQuote] arrow quotation `<some_key>`
  ///
  /// [JsonQuotation.doubleQuote] double quotation `"some_key"`
  ///
  /// [JsonQuotation.singleQuote] single quotation `'some_key'`
  ///
  /// [JsonQuotation.same] left and right quotation are same `<leftQuotation>some_key<rightQuotation>`
  const JsonQuotation({
    this.leftQuote = '',
    this.rightQuote = '',
  });

  /// left qoute and right qoute are same
  const JsonQuotation.same(String quote)
      : leftQuote = quote,
        rightQuote = quote;

  /// arrow quotation
  static JsonQuotation arrowQuote =
      const JsonQuotation(leftQuote: '<', rightQuote: '>');

  /// double quotation
  static JsonQuotation doubleQuote = const JsonQuotation.same('"');

  /// single quotation
  static JsonQuotation singleQuote = const JsonQuotation.same('\'');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonQuotation &&
        other.leftQuote == leftQuote &&
        other.rightQuote == rightQuote;
  }

  @override
  int get hashCode => hashValues(leftQuote, rightQuote);
}

/// json style scheem
class JsonStyleScheme {
  /// text style for keys
  final TextStyle? keysStyle;

  /// text style for values
  final TextStyle? valuesStyle;

  /// add double quotation on keys or not. default set to false
  final JsonQuotation? quotation;

  final Widget? arrow;

  /// Json color scheme
  const JsonStyleScheme({
    this.keysStyle = const TextStyle(),
    this.valuesStyle = const TextStyle(),
    this.quotation = const JsonQuotation(),
    this.arrow,
  });

  /// copy another JsonStyleScheme
  JsonStyleScheme copyWith({
    TextStyle? keysStyle,
    TextStyle? valuesStyle,
    JsonQuotation? quotation,
    Widget? arrow,
  }) {
    return JsonStyleScheme(
      keysStyle: keysStyle ?? this.keysStyle,
      valuesStyle: valuesStyle ?? this.valuesStyle,
      quotation: quotation ?? this.quotation,
      arrow: arrow ?? this.arrow,
    );
  }

  /// merge another JsonStyleScheme
  JsonStyleScheme merge(JsonStyleScheme? scheme) {
    if (scheme == null) return this;
    return copyWith(
      keysStyle: scheme.keysStyle,
      valuesStyle: scheme.valuesStyle,
      quotation: scheme.quotation,
      arrow: scheme.arrow,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonStyleScheme &&
        other.keysStyle == keysStyle &&
        other.valuesStyle == valuesStyle &&
        other.quotation == quotation &&
        other.arrow == arrow;
  }

  @override
  int get hashCode => hashValues(keysStyle, valuesStyle, quotation, arrow);
}
