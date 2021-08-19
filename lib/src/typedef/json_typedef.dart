import 'package:flutter/material.dart';

///custom jsonTileBuilder
typedef JsonTileBuilder = Widget Function(
  BuildContext context,
  int index,
  String name,
  dynamic value,
);
