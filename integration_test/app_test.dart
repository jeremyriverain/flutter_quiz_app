// ignore_for_file: avoid-ignoring-return-values

import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/quiz_entry.dart';
import 'package:flutter_quiz/models/quiz_response.dart';
import 'package:flutter_quiz/quiz.dart';
import 'package:flutter_quiz/repository/quiz_repository.dart';
import 'package:flutter_quiz/repository/quiz_repository_provider.dart';
import 'package:flutter_quiz/store/correct_answer_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

// ignore: prefer-match-file-name
class MockRepository extends Mock implements QuizRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  void expectScoreWidgetToContain(int score) {
    expect(
      find.descendant(
        of: find.byKey(const Key('score')),
        matching: find.textContaining(score.toString()),
      ),
      findsOneWidget,
    );
  }

  mockFetchQuiz({required int numberOfQuestions, required String question}) {
    return Future(
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
    );
  }

  testWidgets('the user loses', (tester) async {
    final mockRepository = MockRepository();

    const numberOfQuestions = 3;

    const question = '- to be or not to be ';
    when(() => mockRepository.fetchQuiz()).thenAnswer(
      (_) => mockFetchQuiz(
        numberOfQuestions: numberOfQuestions,
        question: question,
      ),
    );

    runApp(
      QuizRepositoryProvider(
        quizRepository: mockRepository,
        child: const CorrectAnswerProvider(child: Quiz()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start a quiz'));
    await tester.pumpAndSettle();

    verify(() => mockRepository.fetchQuiz()).called(1);

    for (var index = 0; index < numberOfQuestions; index++) {
      expectScoreWidgetToContain(0);

      expect(find.text('$index $question'), findsOneWidget);
      await tester.tap(find.text('not to be'));
      await tester.pumpAndSettle();

      expectScoreWidgetToContain(0);

      const errorMessage = 'Try again';
      if (index == numberOfQuestions - 1) {
        expect(find.text(errorMessage), findsOneWidget);
      } else {
        expect(find.text(errorMessage), findsNothing);
      }
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text('Start a quiz'));
    await tester.pumpAndSettle();
    expectScoreWidgetToContain(0);
  });

  testWidgets('the user wins', (tester) async {
    final mockRepository = MockRepository();

    const numberOfQuestions = 3;

    const question = '- to be or not to be ';
    when(() => mockRepository.fetchQuiz()).thenAnswer(
      (_) => mockFetchQuiz(
        numberOfQuestions: numberOfQuestions,
        question: question,
      ),
    );

    runApp(
      QuizRepositoryProvider(
        quizRepository: mockRepository,
        child: const CorrectAnswerProvider(child: Quiz()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start a quiz'));
    await tester.pumpAndSettle();

    verify(() => mockRepository.fetchQuiz()).called(1);

    for (var index = 0; index < numberOfQuestions; index++) {
      expectScoreWidgetToContain(index);

      expect(find.text('$index $question'), findsOneWidget);
      await tester.tap(find.text('to be'));
      await tester.pumpAndSettle();

      expectScoreWidgetToContain(index + 1);

      const successMessage = 'Bravo';
      if (index == numberOfQuestions - 1) {
        expect(find.text(successMessage), findsOneWidget);
      } else {
        expect(find.text(successMessage), findsNothing);
      }
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text('Start a quiz'));
    await tester.pumpAndSettle();
    expectScoreWidgetToContain(0);
  });
}
