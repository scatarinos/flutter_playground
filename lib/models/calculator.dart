import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculation {
  List<String> stack = ['0'];
  String get result => stack.join(' ');

  // all operatiopns but last one
  List<String> get stackExceptLast =>
      stack.take(max(stack.length - 1, 0)).toList();

  // last operation
  String get lastOperation => stack.isNotEmpty ? stack[stack.length - 1] : '';

  Calculation();
}

class Calculator extends StateNotifier<Calculation> {
  // double calculation = 0;
  Calculator(Calculation state) : super(state);

  void process(String code) {
    Calculation current = state;

    switch (code) {
      case 'clear':
        state = Calculation();
        break;
      case 'enter':
        Parser p = Parser();
        Expression exp = p.parse(state.stack.join());
        double value = exp.evaluate(EvaluationType.REAL, ContextModel());
        state = Calculation()..stack = ['$value'];
        break;
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '.':
      case ',':
        if (!['+', '-', '/', '*'].contains(current.lastOperation)) {
          state = Calculation()
            ..stack = [
              ...current.stackExceptLast,
              [
                // discard leading '0'
                if (current.lastOperation != '0') current.lastOperation,
                // ensure just one decimal point
                if (!(current.lastOperation.contains('.') && code == '.')) code,
              ].join(),
            ];
        } else {
          state = Calculation()
            ..stack = [
              ...current.stackExceptLast,
              current.lastOperation,
              code,
            ];
        }
        break;
      case '+':
      case '-':
      case '/':
      case '*':
        if (!['+', '-', '/', '*'].contains(state.lastOperation)) {
          state = Calculation()
            ..stack = [
              ...current.stackExceptLast,
              current.lastOperation,
              code,
            ];
        }
        break;
      default:
        break;
    }
  }
}

final calculatorProvider = StateNotifierProvider<Calculator, Calculation>(
    (_) => Calculator(Calculation()));
