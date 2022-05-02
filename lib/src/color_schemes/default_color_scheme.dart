import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_config.dart';

const defaultLightColorScheme = JsonColorScheme(
  nullColor: Colors.teal,
  boolColor: Colors.blue,
  numColor: Colors.green,
  stringColor: Colors.orange,
  normalColor: Colors.grey,
  markColor: Colors.black87,
);

final defaultDarkColorScheme = JsonColorScheme(
  nullColor: Colors.teal[200]!,
  boolColor: Colors.blue[200]!,
  numColor: Colors.green[200]!,
  stringColor: Colors.orange[200]!,
  normalColor: Colors.grey,
  markColor: Colors.white70,
);
