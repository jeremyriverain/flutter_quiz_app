import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/components/quiz_answer.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/layout.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/repository.dart';
import 'package:flutter_quiz/views/result_view.dart';
import 'package:html_unescape/html_unescape.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final Repository quizRepository = Repository();
  final int index = 0;
  final _random = Random();
  bool? invalid;

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: FutureBuilder(
            future: quizRepository.fetchQuiz(),
            builder: (context, AsyncSnapshot<List<QuizEntry>> snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Une erreur est survenue pendant la récupération du quiz.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                );
              }
              final quiz = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting ||
                  quiz == null) {
                return const CircularProgressIndicator();
              }

              final QuizEntry quizEntry = quiz[index];
              final indexCorrectAnswer = next(0, 4);
              var answers = quizEntry.incorrectAnswers;
              answers.insert(indexCorrectAnswer, quizEntry.correctAnswer);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${index + 1} of $kNumberOfQuestions Question'),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                    child: Column(
                      children: [
                        Text(
                          HtmlUnescape().convert(quizEntry.question),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: answers
                        .map(
                          (e) => QuizAnswer(
                            answer: e,
                            onTap: () {},
                          ),
                        )
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 10),
                        child: ElevatedButton(
                          child: const Text('Next'),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResultView(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
