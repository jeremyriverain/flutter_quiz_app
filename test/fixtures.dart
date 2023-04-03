import 'package:flutter_quiz/model.dart';

QuizEntry createQuizEntry() {
  return QuizEntry(
      question: 'to be or not to be ?',
      correctAnswer: 'dream',
      incorrectAnswers: ['not to be', 'to be']);
}
