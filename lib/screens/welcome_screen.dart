import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_screen.dart';
import 'package:flutter_quiz/store/correct_answer_provider.dart';
import 'package:flutter_quiz/theme_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  onStartQuiz(BuildContext context) {
    CorrectAnswerProvider.of(context).reset();
    // ignore: avoid-ignoring-return-values
    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return Container();
      },
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);

        return Transform.scale(
          scale: curve,
          child: const QuizScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "Let's play",
                  style: textTheme.headlineLarge?.copyWith(
                    color: const Color(0xFFF35B79),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Can you answer 6 questions in a row?",
                  style: textTheme.headlineSmall
                      ?.copyWith(color: const Color(0xFFB3B0B0)),
                ),
              ),
              const SizedBox(height: 90),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  boxShadow: [ThemeConstants.boxShadow],
                  gradient: ThemeConstants.blueGradient,
                ),
                constraints:
                    const BoxConstraints(maxWidth: ThemeConstants.maxWidth),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    clipBehavior: Clip.none,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.play_arrow_rounded,
                          size: 35,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Start a quiz',
                          style: textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        onTap: () => onStartQuiz(context),
                      ),
                      Positioned(
                        top: -120,
                        right: 40,
                        child: Image.asset(
                          'images/hot_air_balloons.png',
                          width: 130,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
