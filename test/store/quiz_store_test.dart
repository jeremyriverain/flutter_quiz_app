import 'package:flutter_quiz/store/quiz_store.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures.dart';

void main() {
  group('QuizStore', () {
    test('initial state OK', () {
      final quizStore = QuizStore();
      expect(quizStore.entries.length, 0);
      expect(() => quizStore.entries.removeLast(), throwsUnsupportedError);
    });

    test('setQuiz', () {
      final quizStore = QuizStore();
      expect(quizStore.entries.length, 0);
      quizStore.setQuiz([createQuizEntry()]);
      expect(quizStore.entries.length, 1);
      expect(quizStore.entries[0].question, 'to be or not to be ?');
    });
  });
}
