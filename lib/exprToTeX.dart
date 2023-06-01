import 'package:math_expressions/math_expressions.dart';


class MathParser {

  String parse(String expr) {
    if (expr.isEmpty) {
      return '';
    }
    Parser p = new Parser();
    print(p.parse("3+2"));
    print(expr);
    Expression ex = p.parse(expr);
    print(ex );
    return ex.toString();
  }
}