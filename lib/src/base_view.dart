import 'package:flutter/material.dart';

import 'json_inner_list.dart';
import 'json_inner_view.dart';
class BaseView extends StatefulWidget {
  final dynamic json;
  BaseView({Key? key, required this.json}) : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    assert(widget.json is Map || widget.json is List, 'unsupport type');
    if (widget.json is Map) {
      return JsonInnerView(
        json: widget.json,
        name: 'root',
      );
    }

    if (widget.json is List) {
      return JsonInnerList(
        items: widget.json as List,
        name: 'root',
      );
    }

    return SizedBox();
  }
}
