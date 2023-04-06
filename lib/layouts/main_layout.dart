import 'package:flutter/material.dart';
import 'package:flutter_quiz/constants.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: kBlueGradient,
        ),
        child: child,
      ),
    );
  }
}
