import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_view.dart';

import '../models/json_config_data.dart';

class JsonConfig extends InheritedWidget {
  /// json configuration data
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

    if (viewData == null) {
      viewData = current?.data;
    } else {
      viewData = viewData.merge(current?.data);
    }

    if (viewData == null) {
      viewData = JsonConfigData.fallback(context);
    } else {
      viewData = JsonConfigData.fallback(context).merge(viewData);
    }

    return viewData;
  }
}
