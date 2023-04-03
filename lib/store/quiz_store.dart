import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/model.dart';

class QuizStore extends ChangeNotifier {
  final List<QuizEntry> _entries = [];

  UnmodifiableListView<QuizEntry> get entries => UnmodifiableListView(_entries);

  void setQuiz(List<QuizEntry> quiz) {
    _entries.clear();
    _entries.addAll(quiz);
    notifyListeners();
  }
}
