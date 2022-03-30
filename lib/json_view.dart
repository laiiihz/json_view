library json_view;

import 'package:json_view/src/ast/json_ast.dart' as ast;
export 'package:json_view/src/ast/json_ast.dart' hide compile;
export './src/configuration.dart';
export './src/json_view.dart';

List<ast.JsonNode> getJsonAst(dynamic map) {
  return ast.compile(map);
}
