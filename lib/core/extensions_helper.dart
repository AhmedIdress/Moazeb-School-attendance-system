import 'package:flutter/material.dart';

extension MedieaHelper on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;
}

extension NavigationHelper on BuildContext {
  void push(Widget widget) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void pushReplacement(Widget widget) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
