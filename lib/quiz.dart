import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/welcome_screen.dart';

class Quiz extends StatelessWidget {
  const Quiz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      title: 'Flutter Quiz',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5472ec),
        textTheme: Theme.of(context)
            .textTheme
            // ignore: no-equal-arguments
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
