import 'package:flutter/material.dart';
import 'package:flutter_quiz/repository.dart';
import 'package:flutter_quiz/screens/welcome_screen.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(
    correctAnswerStore: CorrectAnswerStore(),
    repository: Repository(),
  ));
}

const kPrimaryColor = Color(0xFF5472ec);

class MyApp extends StatelessWidget {
  final Repository repository;
  final CorrectAnswerStore correctAnswerStore;
  const MyApp({
    super.key,
    required this.repository,
    required this.correctAnswerStore,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => correctAnswerStore),
        Provider(create: (_) => repository),
      ],
      child: MaterialApp(
        title: 'Flutter Quiz',
        debugShowCheckedModeBanner: false,
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
        home: const WelcomeScreen(),
      ),
    );
  }
}
