import 'package:flutter/material.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_quiz/store/quiz_store.dart';
import 'package:flutter_quiz/views/welcome_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

const kPrimaryColor = Color.fromRGBO(188, 0, 74, 1.0);

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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 17),
            ),
          ),
        ),
        home: const WelcomeView(),
      ),
    );
  }
}
