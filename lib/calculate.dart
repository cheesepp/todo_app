import 'package:flutter/cupertino.dart';

class Calculate extends ChangeNotifier {
  int charToNum(String obj) {
    int num = 0;
    int m = 1;
    for (int index = obj.length - 1; index >= 0; index--) {
      num = num + m * int.parse(obj[index]);
      m = m * 10;
    }
    return num;
  }

  int sumToString(String operand1, String operand2) {
    return charToNum(operand1) + charToNum(operand2);
  }
}
