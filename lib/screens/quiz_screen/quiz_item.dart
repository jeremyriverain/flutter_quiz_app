import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz/models/quiz_entry.dart';
import 'package:flutter_quiz/screens/quiz_screen/confetti.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_answer.dart';
import 'package:flutter_quiz/stores/correct_answer_store.dart';
import 'package:flutter_quiz/theme_constants.dart';
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

  int indexCorrectAnswer = 0;
  List<String> answers = [];

  // ignore: avoid-late-keyword
  late ConfettiController _controllerBottomCenter;

  void setQuizEntryState() {
    indexCorrectAnswer =
        next(0, widget.quiz[index].incorrectAnswers.length + 1);
    answers = widget.quiz[index].incorrectAnswers;
    answers.insert(indexCorrectAnswer, widget.quiz[index].correctAnswer);
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

  void onTapAnswer(MapEntry<int, String> answer) {
    if (indexSelected != null) {
      return;
    }
    setState(() {
      indexSelected = answer.key;
      canAnswerNextQuestion = true;
    });
    if (indexCorrectAnswer == indexSelected) {
      HapticFeedback.vibrate();
      Provider.of<CorrectAnswerStore>(context, listen: false).increment();
      if (Provider.of<CorrectAnswerStore>(context, listen: false)
              .correctAnswers ==
          widget.quiz.length) {
        _controllerBottomCenter.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: const BoxConstraints(maxWidth: ThemeConstants.maxWidth),
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
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${index + 1} of ${widget.quiz.length}',
                  style: textTheme.headlineSmall?.copyWith(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.quiz[index].question,
                  style: textTheme.headlineMedium
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
                answer: answer.value,
                onTap: () => onTapAnswer(answer),
                isSelected: answer.key == indexSelected ||
                    (indexSelected != null && isValid),
                isValid: answer.key == indexCorrectAnswer,
              ),
            );
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8.0),
                child: ElevatedButton(
                  onPressed: canAnswerNextQuestion
                      ? () {
                          if (index + 1 == widget.quiz.length) {
                            Provider.of<CorrectAnswerStore>(
                              context,
                              listen: false,
                            ).reset();
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
