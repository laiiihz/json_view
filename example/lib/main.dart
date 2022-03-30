import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'json_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JsonView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int size = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON VIEW')),
      body: JsonViewConfiguration(
        colorScheme: JsonViewColorScheme(),
        child: JsonView(json: jsonData),
      ),
    );
  }
}

class Item extends StatefulWidget {
  final int index;
  final VoidCallback onTap;
  Item({Key? key, required this.index, required this.onTap}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  void initState() {
    super.initState();
    print('build${widget.index}');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      title: Text(widget.index.toString()),
    );
  }
}
