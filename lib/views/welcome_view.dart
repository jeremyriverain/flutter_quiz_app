import 'package:flutter/material.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/views/question_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Let's play",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: const Color(0xFFF35B79),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text("Can you answer 6 questions in a row?",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFFB3B0B0),
                      )),
            ),
            const SizedBox(height: 60),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    kBoxShadow,
                  ],
                  gradient: kBlueGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomRight,
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionView()),
                          );
                        },
                        leading: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                        title: Text(
                          'Start a quiz',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Positioned(
                        top: -120,
                        right: 40,
                        child: Image.asset(
                          'images/montgolfieres.png',
                          width: 130,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
