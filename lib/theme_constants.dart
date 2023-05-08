import 'package:flutter/material.dart';

class ThemeConstants {
  static const blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3592F4), Color(0xFF5472ec)],
    stops: [0.5, 1],
  );

  static const boxShadow = BoxShadow(
    color: Colors.black38,
    offset: Offset(1.0, 3.0),
    blurRadius: 3.0,
    spreadRadius: 0.0,
  );

  static const double maxWidth = 440;

  static const errorGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF06F9F), Color(0xFFED8C69)],
    stops: [0.3, 1],
  );

  static const successGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEFD701), Color(0xFFB8BE08)],
    stops: [0.1, 1],
  );
}
