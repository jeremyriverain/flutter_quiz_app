import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_answer.dart';
import 'package:flutter_quiz/screens/result_screen.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:provider/provider.dart';

class QuizItem extends StatefulWidget {
  final List<QuizEntry> quiz;

  const QuizItem({
    super.key,
    required this.quiz,
  });

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  int index = 0;
  int? indexSelected;
  final random = Random();
  int next(int min, int max) => min + random.nextInt(max - min);
  bool canAnswerNextQuestion = false;

  late QuizEntry quizEntry;
  late int indexCorrectAnswer;
  late List<String> answers;

  void setQuizEntryState() {
    indexCorrectAnswer = next(0, 4);
    quizEntry = widget.quiz[index];
    answers = quizEntry.incorrectAnswers;
    answers.insert(indexCorrectAnswer, quizEntry.correctAnswer);
  }

  @override
  void initState() {
    setQuizEntryState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${index + 1} of $kNumberOfQuestions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 20, color: Colors.white.withOpacity(0.7)),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                quizEntry.question,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ],
          ),
        ),
        Column(
          children: answers.asMap().entries.map((answer) {
            final isValid = answer.key == indexCorrectAnswer;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: QuizAnswer(
                isValid: answer.key == indexCorrectAnswer,
                answer: answer.value,
                isSelected: answer.key == indexSelected ||
                    (indexSelected != null && isValid),
                onTap: () {
                  if (indexSelected != null) {
                    return;
                  }

                  setState(() {
                    indexSelected = answer.key;
                    canAnswerNextQuestion = true;
                  });
                  if (indexCorrectAnswer == indexSelected) {
                    Provider.of<CorrectAnswerStore>(context, listen: false)
                        .increment();
                  }
                },
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 10),
              child: ElevatedButton(
                onPressed: canAnswerNextQuestion
                    ? () {
                        if (index + 1 == kNumberOfQuestions) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const ResultScreen(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        } else {
                          setState(() {
                            indexSelected = null;
                            index++;
                            canAnswerNextQuestion = false;
                            setQuizEntryState();
                          });
                        }
                      }
                    : null,
                child: const Text('Next'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
