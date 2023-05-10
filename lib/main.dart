import 'package:flutter/material.dart';
import 'package:flutter_quiz/quiz.dart';
import 'package:flutter_quiz/repository/quiz_repository.dart';
import 'package:flutter_quiz/repository/quiz_repository_provider.dart';
import 'package:flutter_quiz/store/correct_answer_provider.dart';

void main() {
  runApp(
    QuizRepositoryProvider(
      quizRepository: QuizRepository(),
      child: const CorrectAnswerProvider(child: Quiz()),
    ),
  );
}
