import 'package:flutter/material.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/screens/quiz_screen/index.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 90),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 440),
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
                            showGeneralDialog(
                              context: context,
                              barrierDismissible:
                                  false, // should dialog be dismissed when tapped outside
                              pageBuilder: (_, __, ___) {
                                return Container();
                              },
                              transitionBuilder: (ctx, a1, a2, child) {
                                var curve =
                                    Curves.easeInOut.transform(a1.value);
                                return Transform.scale(
                                  scale: curve,
                                  child: QuizScreen(),
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 300),
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
                            'images/hot_air_balloons.png',
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
      ),
    );
  }
}