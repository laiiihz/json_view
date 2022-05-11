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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON VIEW'),
        bottom: TabBar(
          tabs: const [
            Tab(text: 'Map'),
            Tab(text: 'List'),
          ],
          controller: _tabController,
        ),
      ),
      body: JsonConfig(
        data: JsonConfigData(
          style: const JsonStyleScheme(
            quotation: JsonQuotation.same('"'),
          ),
          color: const JsonColorScheme(
            nullColor: Colors.teal,
            boolColor: Colors.blue,
            numColor: Colors.green,
            stringColor: Colors.orange,
            normalColor: Colors.grey,
            markColor: Colors.black87,
            nullBackground: Colors.white24,
          ),
        ),
        child: TabBarView(
          children: [
            JsonView(
              json: getJsonData(),
              arrow: const Icon(Icons.arrow_right_rounded),
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
