import 'package:flutter/material.dart';
import 'package:flutter_quiz/repositories/quiz_repository.dart';

class QuizRepositoryProvider extends InheritedWidget {
  static QuizRepository of(BuildContext context) {
    final QuizRepositoryProvider? result =
        context.dependOnInheritedWidgetOfExactType<QuizRepositoryProvider>();
    if (result == null) {
      throw 'No QuizRepositoryPrvider found';
    }

    return result.quizRepository;
  }

  final QuizRepository quizRepository;

  const QuizRepositoryProvider({
    super.key,
    required this.quizRepository,
    required super.child,
  });

  @override
  bool updateShouldNotify(QuizRepositoryProvider oldWidget) => false;
}
