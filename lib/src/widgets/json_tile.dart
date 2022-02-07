import 'package:flutter/material.dart';

class JsonTile extends StatelessWidget {
  final String title;
  final dynamic value;
  final Widget? leading;
  const JsonTile({
    Key? key,
    required this.title,
    required this.value,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color valueColor = Colors.orange;
    if (value is bool) {
      valueColor = Colors.blue;
    } else if (value is num) {
      valueColor = Colors.lightGreen;
    } else if (value is String) {
      valueColor = Colors.orange;
    }
    return Row(
      children: [
        if (leading != null)
          IconTheme(
            child: leading!,
            data: IconThemeData(color: Colors.grey),
          ),
        if (leading != null) const SizedBox(width: 4),
        Expanded(
          child: Text.rich(
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
          ),
        ),
      ],
    );
  }
}
