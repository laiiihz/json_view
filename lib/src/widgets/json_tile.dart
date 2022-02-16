import 'package:flutter/material.dart';
import 'package:json_view/src/widgets/json_view_configuration.dart';

class JsonTile extends StatelessWidget {
  final String title;
  final dynamic value;
  final Widget? leading;
  final VoidCallback? onTap;
  const JsonTile({
    Key? key,
    required this.title,
    required this.value,
    this.leading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheme = JsonViewConfiguration.of(context).scheme;
    Color valueColor = scheme.defaultColor;
    if (value is bool) {
      valueColor = scheme.boolColor;
    } else if (value is num) {
      valueColor = scheme.numColor;
    } else if (value is String) {
      valueColor = scheme.stringColor;
    } else if (value == null) {
      valueColor = scheme.nullColor;
    }
    return Row(
      children: [
        SizedBox(
          width: 16,
          child: IconTheme(
            child: leading ?? SizedBox(),
            data: IconThemeData(color: Colors.grey),
          ),
        ),
        Expanded(
          child: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: title, style: TextStyle(color: Colors.grey)),
                TextSpan(text: ' : ', style: TextStyle(color: Colors.black87)),
                TextSpan(
                  text: value.toString(),
                  style: TextStyle(color: valueColor),
                ),
              ],
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
