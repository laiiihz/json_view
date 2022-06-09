import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
import 'json_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JsonView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON VIEW'),
        bottom: TabBar(
          tabs: const [
            Tab(text: 'Map'),
            Tab(text: 'Large List Json'),
            Tab(text: 'List'),
          ],
          controller: _tabController,
        ),
      ),
      body: JsonConfig(
        data: JsonConfigData(
          gap: 100,
          style: const JsonStyleScheme(
            quotation: JsonQuotation.same('"'),
            // set this to true to open all nodes at start
            // use with caution, it will cause performance issue when json items is too large
            openAtStart: false,
            arrow: Icon(Icons.arrow_forward),
            // too large depth will cause performance issue
            depth: 2,
          ),
          color: const JsonColorScheme(),
        ),
        child: TabBarView(
          children: [
            JsonView(
              json: getJsonData(),
            ),
            JsonView(
              json: largeJsonData(),
            ),
            JsonView(
              json: listJsonData(),
              arrow: const Icon(Icons.arrow_right_rounded),
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
