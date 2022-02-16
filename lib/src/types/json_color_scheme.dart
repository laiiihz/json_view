import 'package:flutter/material.dart';

/// a json color wrapper
class JsonColor extends InheritedWidget {
  /// json color scheme
  final JsonColorScheme scheme;
  JsonColor({required Widget child, this.scheme = JsonColorScheme.original})
      : super(child: child);

  @override
  bool updateShouldNotify(JsonColor oldWidget) => oldWidget.scheme != scheme;
  /// get JsonColorScheme from [BuildContext]
  static JsonColorScheme of(BuildContext context) {
    final item = context.dependOnInheritedWidgetOfExactType<JsonColor>();
    if (item == null) {
      return JsonColorScheme.original;
    } else {
      return item.scheme;
    }
  }
}

class JsonColorScheme {
  final Color defaultColor;
  final Color boolColor;
  final Color numColor;
  final Color stringColor;
  final Color nullColor;
  const JsonColorScheme({
    required this.defaultColor,
    required this.boolColor,
    required this.numColor,
    required this.stringColor,
    required this.nullColor,
  });

  static const original = JsonColorScheme(
    defaultColor: Colors.orange,
    boolColor: Colors.blue,
    numColor: Colors.lightGreen,
    stringColor: Colors.orange,
    nullColor: Colors.blueGrey,
  );

  @override
  int get hashCode =>
      hashValues(defaultColor, boolColor, numColor, stringColor, nullColor);

  @override
  bool operator ==(Object other) {
    return other is JsonColorScheme &&
        defaultColor == other.defaultColor &&
        boolColor == other.defaultColor &&
        numColor == other.numColor &&
        stringColor == other.stringColor &&
        nullColor == other.nullColor;
  }
}
