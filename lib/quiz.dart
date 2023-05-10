import 'package:flutter/material.dart';
import 'package:flutter_quiz/repository/quiz_repository.dart';
import 'package:flutter_quiz/repository/quiz_repository_provider.dart';
import 'package:flutter_quiz/screens/welcome_screen.dart';
import 'package:flutter_quiz/stores/correct_answer_store.dart';
import 'package:provider/provider.dart';

class Quiz extends StatelessWidget {
  final QuizRepository repository;
  final CorrectAnswerStore correctAnswerStore;
  const Quiz({
    super.key,
    required this.repository,
    required this.correctAnswerStore,
  });

  @override
  Widget build(BuildContext context) {
    return QuizRepositoryProvider(
      quizRepository: repository,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => correctAnswerStore),
        ],
        child: MaterialApp(
          home: const WelcomeScreen(),
          title: 'Flutter Quiz',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color(0xFF5472ec),
            textTheme: Theme.of(context)
                .textTheme
                // ignore: no-equal-arguments
                .apply(bodyColor: Colors.white, displayColor: Colors.white),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.white),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
