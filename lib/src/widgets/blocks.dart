part of '../json_view.dart';

class BooleanBlock extends StatelessWidget {
  final String keyValue;
  final bool value;
  const BooleanBlock({Key? key, required this.keyValue, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(keyValue),
      subtitle: Text(value.toString()),
      dense: true,
    );
  }
}

class StringBlock extends StatelessWidget {
  final String keyValue;
  final String value;
  const StringBlock({Key? key, required this.keyValue, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(keyValue),
      subtitle: Text(value),
      dense: true,
    );
  }
}

class NumBlock extends StatelessWidget {
  final String keyValue;
  final num value;
  const NumBlock({Key? key, required this.keyValue, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(keyValue),
      subtitle: Text(value.toString()),
      dense: true,
    );
  }
}
