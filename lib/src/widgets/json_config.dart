import 'package:flutter/material.dart';

import '../models/json_config_data.dart';

class JsonConfig extends InheritedWidget {
  final JsonConfigData? data;

  /// configuration of json view
  const JsonConfig({
    Key? key,
    Widget? child,
    this.data,
  }) : super(key: key, child: child ?? const SizedBox.shrink());
  @override
  bool updateShouldNotify(JsonConfig oldWidget) => data != oldWidget.data;

  /// get a [JsonConfig] from [BuildContext]
  static JsonConfigData of(BuildContext context) {
    final current = context.dependOnInheritedWidgetOfExactType<JsonConfig>();
    final fallback = JsonConfigData.fallback(context);
    if (current?.data == null) return fallback;
    return fallback.merge(current!.data);
  }
}
