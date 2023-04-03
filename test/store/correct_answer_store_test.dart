import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CorrectAnswerStoreTest', () {
    test('initial state OK', () {
      final correctAnswerStore = CorrectAnswerStore();
      expect(correctAnswerStore.correctAnswers, 0);
    });

    test('increment', () {
      final correctAnswerStore = CorrectAnswerStore();
      expect(correctAnswerStore.correctAnswers, 0);
      correctAnswerStore.increment();
      expect(correctAnswerStore.correctAnswers, 1);
    });

    test('reset', () {
      final correctAnswerStore = CorrectAnswerStore();
      correctAnswerStore.increment();
      expect(correctAnswerStore.correctAnswers, 1);
      correctAnswerStore.reset();
      expect(correctAnswerStore.correctAnswers, 0);
    });
  });
}
