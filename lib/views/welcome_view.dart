import 'package:flutter/material.dart';
import 'package:flutter_quiz/layout.dart';
import 'package:flutter_quiz/views/question_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        child: ElevatedButton(
          child: const Text('Start a quiz'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => QuestionView()),
            );
          },
        ),
      ),
    );
  }
}
