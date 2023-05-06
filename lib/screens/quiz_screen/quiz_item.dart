import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/screens/quiz_screen/confetti.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_answer.dart';
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
  late ConfettiController _controllerBottomCenter;

  void setQuizEntryState() {
    quizEntry = widget.quiz[index];
    indexCorrectAnswer = next(0, quizEntry.incorrectAnswers.length + 1);
    answers = quizEntry.incorrectAnswers;
    answers.insert(indexCorrectAnswer, quizEntry.correctAnswer);
  }

  @override
  void initState() {
    setQuizEntryState();
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: kMaxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'images/hot_air_balloons.png',
              width: 130,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${index + 1} of $kNumberOfQuestions',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 16, color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  quizEntry.question,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ),
          ...answers.asMap().entries.map((answer) {
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
                    HapticFeedback.vibrate();
                    Provider.of<CorrectAnswerStore>(context, listen: false)
                        .increment();
                    if (Provider.of<CorrectAnswerStore>(context, listen: false)
                            .correctAnswers ==
                        kNumberOfQuestions) {
                      _controllerBottomCenter.play();
                    }
                  }
                },
              ),
            );
          }).toList(),
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
                            Provider.of<CorrectAnswerStore>(context,
                                    listen: false)
                                .reset();
                            Navigator.pop(context);
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
          Confetti(
            controller: _controllerBottomCenter,
          ),
        ],
      ),
    );
  }
}
