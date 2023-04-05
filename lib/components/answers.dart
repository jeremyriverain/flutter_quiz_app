import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/components/answers_item.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_quiz/views/result_view.dart';
import 'package:provider/provider.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('${index + 1} of $kNumberOfQuestions Question'),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12),
            child: Column(
              children: [
                Text(
                  quizEntry.question,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Column(
            children: answers.asMap().entries.map((answer) {
              final isValid = answer.key == indexCorrectAnswer;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: AnswersItem(
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
          Expanded(
            child: Row(
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
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const ResultView(),
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
            ),
          )
        ],
      ),
    );
  }
}
