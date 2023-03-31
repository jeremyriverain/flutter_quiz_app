import 'package:flutter/material.dart';
import 'package:flutter_quiz/layout.dart';
import 'package:flutter_quiz/views/welcome_view.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Column(
          children: [
            Text(
              // 'Congrats 🎉 \nYou made no mistake.',
              'Your score is 6 of 10 🤯.',
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
