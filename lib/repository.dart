import 'dart:convert';

import 'package:flutter_quiz/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<List<QuizEntry>> fetchQuiz({
    int numberOfQuestions = 6,
  }) async {
    final response = await http.get(
      Uri.parse(
          'https://opentdb.com/api.php?amount=$numberOfQuestions&difficulty=easy&type=multiple&encode=url3986'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> l = json.decode(response.body);
      List<QuizEntry> quiz = List<QuizEntry>.from(
        l['results'].map<QuizEntry>((jsonQuizEntry) {
          return QuizEntry.fromJSON(jsonQuizEntry);
        }),
      );
      return quiz;
    } else {
      throw Exception('Failed to load quiz');
    }
  }
}
