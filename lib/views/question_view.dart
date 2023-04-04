import 'package:flutter/material.dart';
import 'package:flutter_quiz/components/answers.dart';
import 'package:flutter_quiz/layouts/default_layout.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/repository.dart';

class QuestionView extends StatelessWidget {
  QuestionView({super.key});

  final Repository quizRepository = Repository();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: FutureBuilder(
            future: quizRepository.fetchQuiz(),
            builder: (context, AsyncSnapshot<List<QuizEntry>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An error occured while fetching the quiz.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                );
              }
              final quiz = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting ||
                  quiz == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Answers(quiz: quiz);
            }),
      ),
    );
  }
}
