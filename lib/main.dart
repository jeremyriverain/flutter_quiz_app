import 'package:flutter/material.dart';
import 'package:flutter_quiz/quiz.dart';
import 'package:flutter_quiz/repository/quiz_repository.dart';
import 'package:flutter_quiz/stores/correct_answer_store.dart';

void main() {
  runApp(Quiz(
    repository: QuizRepository(),
    correctAnswerStore: CorrectAnswerStore(),
  ));
}
