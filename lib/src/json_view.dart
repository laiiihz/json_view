import 'package:flutter/material.dart';
import 'package:json_view/src/base_view.dart';
import 'package:json_view/src/path_view.dart';

class JsonView extends StatefulWidget {
  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
  static JsonListenableList _pathList = JsonListenableList([]);
  static List<String> get path => _pathList.value;
  static add(String path) {
    _pathList.value.add(path);
    _pathList.notifyListeners();
  }

  static pop() {
    _pathList.value.removeLast();
    _pathList.notifyListeners();
  }

  static addListener(VoidCallback function) {
    _pathList.addListener(function);
  }

  static removevListener(VoidCallback function) {
    _pathList.removeListener(function);
  }

  final Map<String, dynamic> map;
  JsonView({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  _JsonViewState createState() => _JsonViewState();
}

class _JsonViewState extends State<JsonView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          PathView(),
          Expanded(
            child: WillPopScope(
              onWillPop: () async {
                var result =
                    await JsonView.navigator.currentState?.maybePop() ?? true;
                if (result) {
                  JsonView.pop();
                }
                return !result;
              },
              child: Navigator(
                key: JsonView.navigator,
                onPopPage: (route, result) {
                  return true;
                },
                onGenerateRoute: (settings) {
                  final routeMap = <String, Widget>{
                    '/': BaseView(json: widget.map),
                  };
                  final now = routeMap[settings.name];
                  if (now == null) return null;
                  return MaterialPageRoute(builder: (context) {
                    return now;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JsonListenableList extends ValueNotifier<List<String>> {
  JsonListenableList(List<String> value) : super(value);
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
