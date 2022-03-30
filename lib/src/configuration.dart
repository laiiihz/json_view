import 'package:flutter/material.dart';
import 'package:json_view/src/ast/json_ast.dart';

class JsonViewConfiguration extends InheritedWidget {
  final JsonViewColorScheme? colorScheme;
  JsonViewConfiguration({
    Key? key,
    required Widget child,
    this.colorScheme,
  }) : super(child: child);

  @override
  bool updateShouldNotify(JsonViewConfiguration oldWidget) {
    return oldWidget.colorScheme != colorScheme;
  }

  static JsonViewConfig of(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<JsonViewConfiguration>();
    bool isLight = Theme.of(context).brightness == Brightness.light;
    final defaultColorScheme =
        isLight ? JsonViewColorScheme.light : JsonViewColorScheme.dark;
    if (data?.colorScheme == null) {
      return JsonViewConfig(colorScheme: defaultColorScheme);
    }
    return JsonViewConfig(
      colorScheme: defaultColorScheme.merge(data!.colorScheme),
    );
  }
}

class JsonViewConfig {
  final JsonViewColorScheme colorScheme;
  const JsonViewConfig({
    required this.colorScheme,
  });

  static const light = JsonViewConfig(colorScheme: JsonViewColorScheme.light);
  static const dark = JsonViewConfig(colorScheme: JsonViewColorScheme.dark);

  JsonViewConfig copyWith({
    JsonViewColorScheme? colorScheme,
  }) {
    return JsonViewConfig(
      colorScheme: this.colorScheme.merge(colorScheme),
    );
  }
}

class JsonViewColorScheme {
  final Color? nullColor;
  final Color? numColor;
  final Color? stringColor;
  final Color? boolColor;
  final Color? defaultColor;
  final Color? keyColor;
  const JsonViewColorScheme({
    this.nullColor,
    this.numColor,
    this.stringColor,
    this.boolColor,
    this.defaultColor,
    this.keyColor,
  });

  Color getByType(JsonValueType type) {
    switch (type) {
      case JsonValueType.nullity:
        return nullColor!;
      case JsonValueType.number:
        return numColor!;
      case JsonValueType.boolean:
        return boolColor!;
      case JsonValueType.string:
        return stringColor!;
    }
  }

  static const light = JsonViewColorScheme(
    nullColor: Colors.black54,
    numColor: Color(0xFF388E3C),
    stringColor: Colors.black87,
    boolColor: Color(0xFF1976D2),
    defaultColor: Colors.black,
    keyColor: Color(0xFFF57C00),
  );

  static const dark = JsonViewColorScheme(
    nullColor: Colors.white54,
    numColor: Color(0xFF81C784),
    stringColor: Colors.white70,
    boolColor: Color(0xFF64B5F6),
    defaultColor: Colors.white,
    keyColor: Color(0xFFFFB74D),
  );

  JsonViewColorScheme copyWith({
    Color? nullColor,
    Color? numColor,
    Color? stringColor,
    Color? boolColor,
    Color? defaultColor,
    Color? keyColor,
  }) {
    return JsonViewColorScheme(
      nullColor: nullColor ?? this.nullColor,
      numColor: numColor ?? this.numColor,
      stringColor: stringColor ?? this.stringColor,
      boolColor: boolColor ?? this.boolColor,
      defaultColor: defaultColor ?? this.defaultColor,
      keyColor: keyColor ?? this.keyColor,
    );
  }

  JsonViewColorScheme merge(JsonViewColorScheme? scheme) {
    if (scheme == null) return this;
    return copyWith(
      nullColor: scheme.nullColor,
      numColor: scheme.numColor,
      stringColor: scheme.stringColor,
      boolColor: scheme.boolColor,
      defaultColor: scheme.defaultColor,
      keyColor: scheme.keyColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonViewColorScheme &&
        other.nullColor == nullColor &&
        other.numColor == numColor &&
        other.stringColor == stringColor &&
        other.boolColor == boolColor;
  }

  @override
  int get hashCode {
    return nullColor.hashCode ^
        numColor.hashCode ^
        stringColor.hashCode ^
        boolColor.hashCode;
  }
}
