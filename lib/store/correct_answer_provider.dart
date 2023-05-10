import 'package:flutter/material.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';

class CorrectAnswerProvider extends StatefulWidget {
  static CorrectAnswerProviderState of(BuildContext context) {
    final result =
        context.findAncestorStateOfType<CorrectAnswerProviderState>();
    if (result == null) {
      throw 'CorrectAnswerProviderState ancestor has not been found';
    }

    return result;
  }

  final Widget child;

  const CorrectAnswerProvider({
    super.key,
    required this.child,
  });

  @override
  State<CorrectAnswerProvider> createState() => CorrectAnswerProviderState();
}

class CorrectAnswerProviderState extends State<CorrectAnswerProvider> {
  int _correctAnswers = 0;

  void increment() {
    setState(() {
      _correctAnswers = _correctAnswers + 1;
    });
  }

  void reset() {
    setState(() {
      _correctAnswers = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CorrectAnswerStore(
      correctAnswers: _correctAnswers,
      child: widget.child,
    );
  }
}
