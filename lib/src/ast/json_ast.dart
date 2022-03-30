enum JsonValueType {
  nullity,
  number,
  boolean,
  string,
}

enum JsonType {
  value,
  map,
  list,
}

class JsonNode<T, K> {
  final JsonType type;
  final JsonValueType valueType;
  final K key;
  final T value;
  final List<JsonNode> children;
  final int deep;
  final String? displayValue;
  final String displayKey;

  const JsonNode({
    required this.type,
    required this.valueType,
    required this.key,
    required this.value,
    required this.deep,
    this.displayValue,
    required this.displayKey,
    this.children = const [],
  });
}

class JsonNodeNull<K> extends JsonNode<Null, K> {
  JsonNodeNull({
    required K key,
    required int deep,
    required String displayKey,
  }) : super(
          type: JsonType.value,
          valueType: JsonValueType.nullity,
          key: key,
          value: null,
          displayValue: 'null',
          deep: deep,
          displayKey: displayKey,
        );
}

class JsonNodeString<K> extends JsonNode<String, K> {
  JsonNodeString({
    required K key,
    required String value,
    required int deep,
    required String displayKey,
  }) : super(
          type: JsonType.value,
          valueType: JsonValueType.string,
          key: key,
          value: value,
          displayValue: '"$value"',
          deep: deep,
          displayKey: displayKey,
        );
}

class JsonNodeNum<K> extends JsonNode<num, K> {
  JsonNodeNum({
    required K key,
    required num value,
    required int deep,
    required String displayKey,
  }) : super(
          type: JsonType.value,
          valueType: JsonValueType.number,
          key: key,
          value: value,
          displayValue: '$value',
          deep: deep,
          displayKey: displayKey,
        );
}

class JsonNodeBool<K> extends JsonNode<bool, K> {
  JsonNodeBool({
    required K key,
    required bool value,
    required int deep,
    required String displayKey,
  }) : super(
          type: JsonType.value,
          valueType: JsonValueType.boolean,
          key: key,
          value: value,
          displayValue: '$value',
          deep: deep,
          displayKey: displayKey,
        );
}

class JsonNodeList<K> extends JsonNode<Null, K> {
  JsonNodeList({
    required K key,
    required List<JsonNode> children,
    required int deep,
    required String displayKey,
  }) : super(
          type: JsonType.list,
          valueType: JsonValueType.boolean,
          key: key,
          value: null,
          children: children,
          deep: deep,
          displayKey: displayKey,
        );
}

class JsonNodeMap<K> extends JsonNode<Null, K> {
  JsonNodeMap(
      {required K key,
      required List<JsonNode> children,
      required int deep,
      required String displayKey})
      : super(
          type: JsonType.map,
          valueType: JsonValueType.nullity,
          key: key,
          value: null,
          children: children,
          deep: deep,
          displayKey: displayKey,
        );
}

List<JsonNode> compile(dynamic map) {
  if (map is List) return _compileList(map, 0);
  if (map is Map) return _compileMap(map, 0);
  throw Exception('Unknown Type');
}

List<JsonNode> _compileList(List map, int deep) {
  final currentNodes = <JsonNode>[];
  for (var i = 0; i < map.length; i++) {
    final item = map[i];
    if (item == null) {
      currentNodes
          .add(JsonNodeNull<int>(key: i, deep: deep, displayKey: '[$i]'));
    }
    if (item is String) {
      currentNodes.add(JsonNodeString<int>(
          key: i, value: item, deep: deep, displayKey: '[$i]'));
    }
    if (item is num) {
      currentNodes.add(JsonNodeNum<int>(
          key: i, value: item, deep: deep, displayKey: '[$i]'));
    }
    if (item is bool) {
      currentNodes.add(JsonNodeBool<int>(
          key: i, value: item, deep: deep, displayKey: '[$i]'));
    }
    if (item is List) {
      currentNodes.add(JsonNodeList<int>(
          key: i,
          children: _compileList(item, deep + 1),
          deep: deep,
          displayKey: '[$i]'));
    }
    if (item is Map) {
      currentNodes.add(JsonNodeMap<int>(
          key: i,
          children: _compileMap(item, deep + 1),
          deep: deep,
          displayKey: '[$i]'));
    }
  }
  return currentNodes;
}

List<JsonNode> _compileMap(Map map, int deep) {
  final currentNodes = <JsonNode>[];
  final entries = map.entries.toList();
  for (var i = 0; i < entries.length; i++) {
    final key = entries[i].key;
    final item = entries[i].value;
    if (item == null) {
      currentNodes.add(
          JsonNodeNull<String>(key: key, deep: deep, displayKey: '"$key"'));
    }
    if (item is String) {
      currentNodes.add(JsonNodeString<String>(
          key: key, value: item, deep: deep, displayKey: '"$key"'));
    }
    if (item is num) {
      currentNodes.add(JsonNodeNum<String>(
          key: key, value: item, deep: deep, displayKey: '"$key"'));
    }
    if (item is bool) {
      currentNodes.add(JsonNodeBool<String>(
          key: key, value: item, deep: deep, displayKey: '"$key"'));
    }
    if (item is List) {
      currentNodes.add(JsonNodeList<String>(
          key: key,
          children: _compileList(item, deep + 1),
          deep: deep,
          displayKey: '"$key"'));
    }
    if (item is Map) {
      currentNodes.add(JsonNodeMap<String>(
          key: key,
          children: _compileMap(item, deep + 1),
          deep: deep,
          displayKey: '"$key"'));
    }
  }
  return currentNodes;
}
