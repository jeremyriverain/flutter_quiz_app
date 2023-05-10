import 'package:flutter/material.dart';

class CorrectAnswerStore extends InheritedWidget {
  static CorrectAnswerStore of(BuildContext context) {
    final CorrectAnswerStore? result =
        context.dependOnInheritedWidgetOfExactType<CorrectAnswerStore>();

    if (result == null) {
      throw 'No CorrectAnswerStore found';
    }

    return result;
  }

  final int correctAnswers;

  const CorrectAnswerStore({
    super.key,
    required this.correctAnswers,
    required super.child,
  });

  @override
  bool updateShouldNotify(CorrectAnswerStore oldWidget) {
    return correctAnswers != oldWidget.correctAnswers;
  }
}
