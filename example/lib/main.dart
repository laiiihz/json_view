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
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int size = 100;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON VIEW'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Map'),
            Tab(text: 'List'),
          ],
          controller: _tabController,
        ),
      ),
      body: JsonConfig(
        data: JsonConfigData(
          style: JsonStyleScheme(
            quotation: '">',
          ),
          color: JsonColorScheme(
            nullBackground: const Color(0xFFEBEBEB),
            nullColor: Colors.teal,
            boolColor: Colors.blue,
            numColor: Colors.green,
            stringColor: Colors.orange,
            normalColor: Colors.grey,
            markColor: Colors.black87,
          ),
        ),
        child: TabBarView(
          children: [
            JsonView(
              json: getJsonData(),
              openAtStart: true,
              arrow: Icon(Icons.arrow_drop_down_rounded),
            ),
            JsonView(
              json: listJsonData(),
              arrow: Icon(Icons.arrow_drop_down_rounded),
            ),
          ],
          controller: _tabController,
        ),
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
