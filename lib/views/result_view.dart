import 'package:flutter/material.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/layout.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_quiz/views/welcome_view.dart';
import 'package:provider/provider.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final correctAnswers =
        Provider.of<CorrectAnswerStore>(context, listen: false).correctAnswers;
    return Layout(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Column(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Provider.of<CorrectAnswerStore>(context, listen: false)
                        .reset();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeView(),
                      ),
                    );
                  },
                  child: const Text('Start new quiz'),
                ),
                ElevatedButton(
                  child: const Text('Try again'),
                  onPressed: () {
                    Provider.of<CorrectAnswerStore>(context, listen: false)
                        .reset();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
