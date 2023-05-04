import 'package:flutter/material.dart';

const kNumberOfQuestions = 6;

// THEMING

const kBlueGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.5, 1],
  colors: [
    Color(0xFF3592F4),
    Color(0xFF5472ec),
  ],
);

const kBoxShadow = BoxShadow(
  color: Colors.black38,
  blurRadius: 3.0,
  spreadRadius: 0.0,
  offset: Offset(1.0, 3.0),
);

const double kMaxWidth = 440;
