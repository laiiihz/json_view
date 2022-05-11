library json_view;

import 'package:flutter/material.dart';
import 'package:json_view/src/models/json_config_data.dart';
import 'package:json_view/src/widgets/json_config.dart';

export 'src/widgets/json_view.dart';
export 'src/widgets/json_config.dart';

export 'src/models/json_config_data.dart';
export 'src/models/json_color_scheme.dart';
export 'src/models/json_style_scheme.dart';

Widget jsonViewConfigBuilder(JsonConfigData config, Widget? child) =>
    JsonConfig(data: config, child: child);
