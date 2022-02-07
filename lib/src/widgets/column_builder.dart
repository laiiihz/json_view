import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  const ColumnBuilder(
      {Key? key, required this.itemCount, required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => itemBuilder(context, index),
      ),
    );
  }
}
