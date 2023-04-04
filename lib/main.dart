import 'package:flutter/material.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_quiz/store/quiz_store.dart';
import 'package:flutter_quiz/views/welcome_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

const kPrimaryColor = Color(0xFF5472ec);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CorrectAnswerStore()),
        ChangeNotifierProvider(create: (context) => QuizStore()),
      ],
      child: MaterialApp(
        title: 'Flutter Quiz',
        theme: ThemeData(
          colorSchemeSeed: kPrimaryColor,
          useMaterial3: true,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        home: const WelcomeView(),
      ),
    );
  }
}
