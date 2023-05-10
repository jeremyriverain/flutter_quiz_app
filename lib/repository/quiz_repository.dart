import 'dart:convert';

import 'package:flutter_quiz/models/quiz_entry.dart';
import 'package:http/http.dart' as http;

class QuizRepository {
  Future<List<QuizEntry>> fetchQuiz({
    int numberOfQuestions = 6,
  }) async {
    final response = await http.get(
      Uri.parse(
        'https://opentdb.com/api.php?amount=$numberOfQuestions&difficulty=easy&type=multiple&encode=url3986',
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      return List<QuizEntry>.from(
        body['results'].map<QuizEntry>((jsonQuizEntry) {
          return QuizEntry.fromJSON(jsonQuizEntry);
        }),
      );
    } else {
      throw 'An error occured while fetching the quiz';
    }
  }
}
