import 'package:flutter_quiz/models/quiz_entry.dart';

class QuizResponse {
  final List<QuizEntry> quiz;
  final bool hasError;

  QuizResponse({
    this.quiz = const [],
    this.hasError = true,
  });
}
