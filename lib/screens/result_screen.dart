import 'package:flutter/material.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_quiz/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final correctAnswers =
        Provider.of<CorrectAnswerStore>(context, listen: false).correctAnswers;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: kBlueGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                correctAnswers == kNumberOfQuestions
                    ? 'Congrats 🎉 \nYou made no mistake.'
                    : 'Your score is $correctAnswers of $kNumberOfQuestions 🤯.',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<CorrectAnswerStore>(context, listen: false)
                          .reset();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                      );
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
