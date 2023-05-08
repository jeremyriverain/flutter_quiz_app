import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/quiz_entry.dart';
import 'package:flutter_quiz/models/quiz_response.dart';
import 'package:flutter_quiz/quiz.dart';
import 'package:flutter_quiz/repositories/quiz_repository.dart';
import 'package:flutter_quiz/screens/quiz_screen/confetti.dart';
import 'package:flutter_quiz/stores/correct_answer_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements QuizRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integration test', (tester) async {
    void expectScoreWidgetToContain(int score) {
      expect(
        find.descendant(
          of: find.byKey(const Key('score')),
          matching: find.textContaining(score.toString()),
        ),
        findsOneWidget,
      );
    }

    void expectConfettiControllerState(
      ConfettiControllerState confettiControllerState,
    ) {
      expect(
        (find.byType(Confetti).evaluate().first.widget as Confetti)
            .controller
            .state,
        confettiControllerState,
      );
    }

    final mockRepository = MockRepository();

    const numberOfQuestions = 3;

    const question = '- to be or not to be ';
    when(() => mockRepository.fetchQuiz()).thenAnswer(
      (_) => Future(
        () => QuizResponse(
          quiz: List.generate(
            numberOfQuestions,
            (index) => QuizEntry(
              question: '$index $question',
              correctAnswer: 'to be',
              incorrectAnswers: ['not to be'],
            ),
          ),
          hasError: false,
        ),
      ),
    );

    final correctAnswerStore = CorrectAnswerStore();

    runApp(Quiz(
      repository: mockRepository,
      correctAnswerStore: correctAnswerStore,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start a quiz'));
    await tester.pumpAndSettle();

    verify(() => mockRepository.fetchQuiz()).called(1);

    for (var i = 0; i < numberOfQuestions; i++) {
      expectScoreWidgetToContain(i);
      expect(correctAnswerStore.correctAnswers, equals(i));

      expect(find.text('$i $question'), findsOneWidget);
      await tester.tap(find.text('to be'));
      await tester.pump(const Duration(milliseconds: 100));

      expectScoreWidgetToContain(i + 1);
      expect(correctAnswerStore.correctAnswers, equals(i + 1));

      if (i == numberOfQuestions - 1) {
        expectConfettiControllerState(ConfettiControllerState.playing);
      } else {
        expectConfettiControllerState(ConfettiControllerState.stopped);
      }
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text('Start a quiz'));
    await tester.pumpAndSettle();
    expectScoreWidgetToContain(0);
  });
}
