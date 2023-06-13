import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_view.dart';

import '../models/json_config_data.dart';

class JsonConfig extends InheritedWidget {
  /// configuration of json view
  const JsonConfig({
    super.key,
    Widget? child,
    this.data,
  }) : super(child: child ?? const SizedBox.shrink());

  /// json configuration data
  final JsonConfigData? data;

  @override
  bool updateShouldNotify(JsonConfig oldWidget) => data != oldWidget.data;

  /// get a [JsonConfig] from [BuildContext]
  static JsonConfigData of(BuildContext context) {
    final view = context.findAncestorWidgetOfExactType<JsonView>();
    final body = context.findAncestorWidgetOfExactType<JsonViewBody>();
    assert(
      view == null || body == null,
      'must provider a JsonView or JsonViewBody',
    );
    JsonConfigData? viewData;
    if (view != null) {
      viewData = JsonConfigData.fromJsonView(view);
    } else if (body != null) {
      viewData = JsonConfigData.fromJsonViewBody(body);
    }

    final current = context.dependOnInheritedWidgetOfExactType<JsonConfig>();
    final fallback = JsonConfigData.fallback(context);

    if (viewData == null) {
      viewData = fallback.merge(current?.data);
    } else {
      viewData = fallback.merge(current?.data).merge(viewData);
    }

    return viewData;
  }
}
