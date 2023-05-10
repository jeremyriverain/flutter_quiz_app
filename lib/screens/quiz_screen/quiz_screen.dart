import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/quiz_response.dart';
import 'package:flutter_quiz/repository/quiz_repository_provider.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_item.dart';
import 'package:flutter_quiz/screens/quiz_screen/score.dart';
import 'package:flutter_quiz/theme_constants.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void onClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ThemeConstants.blueGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Score(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconButton(
                onPressed: () => onClose(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leadingWidth: 200,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20.0),
          child: FutureProvider<QuizResponse?>(
            create: (_) => QuizRepositoryProvider.of(context).fetchQuiz(),
            initialData: null,
            child: Consumer<QuizResponse?>(builder: (_, quizResponse, __) {
              if (quizResponse == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (quizResponse.hasError) {
                return Text(
                  'An error occurred while fetching the quiz.',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }

              return SingleChildScrollView(
                child: QuizItem(
                  quiz: quizResponse.quiz,
                ),
              );
            }),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
