import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorProvider extends ChangeNotifier {
  String _displayText = "0";

  String get displayText => _displayText;
  void setValue(String Value) {
    if (displayText == "0" && Value != "0") {
      _displayText = Value;
    } else {
      switch (Value) {
        case "AC":
          _displayText = "0";
          break;
        case 'x':
          _displayText = _displayText += "*";
          break;
        case '=':
          calculate();
          break;
        default:
          _displayText += Value;
      }
    }
    notifyListeners();
  }

  void calculate() {
    try {
      String expressions = _displayText.replaceAll("x", "*");
      num result = expressions.interpret();
      _displayText = result == result.toInt()
          ? result.toInt().toString()
          : result.toString();
    } catch (e) {
      _displayText = "Error";
    }
    notifyListeners();
  }

  void toggleSign() {
    if (displayText.isNotEmpty) {
      double currentValue = double.tryParse(displayText) ?? 0;
      currentValue = -currentValue;
      _displayText = currentValue.toString();
      notifyListeners();
    }
  }
}
