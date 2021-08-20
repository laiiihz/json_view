import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';

class PathView extends StatefulWidget {
  final double height;
  PathView({Key? key, this.height = 40}) : super(key: key);

  @override
  _PathViewState createState() => _PathViewState();
}

class _PathViewState extends State<PathView> {
  final ScrollController _scrollController = ScrollController();
  update() {
    _scrollController.animateTo(
      -10,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    JsonView.path.clear();
    JsonView.addListener(update);
  }

  @override
  void dispose() {
    JsonView.removevListener(update);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.separated(
        controller: _scrollController,
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 16),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index != JsonView.path.length) {
            return Center(child: Text(JsonView.path.reversed.toList()[index]));
          }
          return Center(child: Text('ROOT'));
        },
        separatorBuilder: (context, index) => Icon(Icons.arrow_right),
        itemCount: JsonView.path.length + 1,
      ),
    );
  }
}
