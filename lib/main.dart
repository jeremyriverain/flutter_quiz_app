import 'package:flutter/material.dart';
import 'package:flutter_quiz/views/welcome_view.dart';

void main() {
  runApp(const MyApp());
}

const kPrimaryColor = Color.fromRGBO(188, 0, 74, 1.0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    );
  }
}
