import 'dart:js';

import 'package:flutter/material.dart';

/// a JsonViewConfiguration widget
class JsonViewConfiguration extends InheritedWidget {
  /// JsonViewConfiguration data
  final JsonViewConfigurationData data;
  JsonViewConfiguration(
      {required Widget child, this.data = JsonViewConfigurationData.original})
      : super(child: child);

  @override
  bool updateShouldNotify(JsonViewConfiguration oldWidget) =>
      oldWidget.data != data;

  /// get JsonViewConfigurationScheme from [BuildContext]
  static JsonViewConfigurationData of(BuildContext context) {
    final item =
        context.dependOnInheritedWidgetOfExactType<JsonViewConfiguration>();
    if (item == null) {
      return JsonViewConfigurationData.original;
    } else {
      return JsonViewConfigurationData.original.merge(item.data);
    }
  }
}

class JsonViewConfigurationData {
  final Duration animation;
  final JsonViewConfigurationScheme scheme;

  const JsonViewConfigurationData({
    required this.scheme,
    required this.animation,
  });

  JsonViewConfigurationData merge(JsonViewConfigurationData data) {
    return copyWith(animation: data.animation, scheme: data.scheme);
  }

  JsonViewConfigurationData copyWith({
    Duration? animation,
    JsonViewConfigurationScheme? scheme,
  }) {
    return JsonViewConfigurationData(
      animation: animation ?? this.animation,
      scheme: scheme ?? this.scheme,
    );
  }

  static const original = JsonViewConfigurationData(
    scheme: JsonViewConfigurationScheme.original,
    animation: Duration(milliseconds: 600),
  );

  @override
  int get hashCode => scheme.hashCode;

  @override
  bool operator ==(Object other) {
    return other is JsonViewConfigurationData && scheme == other.scheme;
  }
}

/// json color scheme
class JsonViewConfigurationScheme {
  /// default color
  final Color defaultColor;

  /// color of [bool]
  final Color boolColor;

  /// color of [num]
  final Color numColor;

  /// color of [String]
  final Color stringColor;

  /// color of null
  final Color nullColor;
  const JsonViewConfigurationScheme({
    required this.defaultColor,
    required this.boolColor,
    required this.numColor,
    required this.stringColor,
    required this.nullColor,
  });

  /// default color
  static const original = JsonViewConfigurationScheme(
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
    return other is JsonViewConfigurationScheme &&
        defaultColor == other.defaultColor &&
        boolColor == other.defaultColor &&
        numColor == other.numColor &&
        stringColor == other.stringColor &&
        nullColor == other.nullColor;
  }
}
