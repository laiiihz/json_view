import 'package:flutter/material.dart';

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
    Color valueColor = Colors.orange;
    if (value is bool) {
      valueColor = Colors.blue;
    } else if (value is num) {
      valueColor = Colors.lightGreen;
    } else if (value is String) {
      valueColor = Colors.orange;
    } else if (value == null) {
      valueColor = Colors.blueGrey;
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
