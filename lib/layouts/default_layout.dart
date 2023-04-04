import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  const DefaultLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.5, 1],
            colors: [
              Color(0xFF3592F4),
              Color(0xFF5472ec),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
