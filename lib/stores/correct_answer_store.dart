import 'package:flutter/material.dart';

class CorrectAnswerStore extends ChangeNotifier {
  int _correctAnswers = 0;

  int get correctAnswers => _correctAnswers;

  void reset() {
    _correctAnswers = 0;
    notifyListeners();
  }

  void increment() {
    _correctAnswers++;
    notifyListeners();
  }
}
