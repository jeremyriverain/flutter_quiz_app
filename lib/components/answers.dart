import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/components/answers_item.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/views/result_view.dart';
import 'package:html_unescape/html_unescape.dart';

class Answers extends StatefulWidget {
  final List<QuizEntry> quiz;

  const Answers({
    super.key,
    required this.quiz,
  });

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    int next(int min, int max) => min + random.nextInt(max - min);
    final QuizEntry quizEntry = widget.quiz[index];
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
                (e) => AnswersItem(
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
                  if (index + 1 == kNumberOfQuestions) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResultView(),
                      ),
                    );
                  } else {
                    setState(() {
                      index++;
                    });
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
