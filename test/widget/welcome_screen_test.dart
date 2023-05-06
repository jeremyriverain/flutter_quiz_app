import 'package:flutter/material.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/repository.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_screen.dart';
import 'package:flutter_quiz/screens/welcome_screen.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  testWidgets('WelcomeScreen widget allows to navigate to QuizScreen',
      (tester) async {
    final mockRepository = MockRepository();
    when(() => mockRepository.fetchQuiz()).thenAnswer(
      (_) => Future(
        () => List.generate(
          4,
          (index) => QuizEntry(
            question: 'to be or not to be ?',
            correctAnswer: 'to be',
            incorrectAnswers: ['not to be'],
          ),
        ),
      ),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CorrectAnswerStore(),
          ),
          Provider<Repository>(create: (_) => mockRepository),
        ],
        child: Builder(builder: (context) {
          return const MaterialApp(home: WelcomeScreen());
        }),
      ),
    );

    expect(find.text('Start a quiz'), findsOneWidget);
    expect(find.byType(QuizScreen), findsNothing);

    await tester.tap(find.text('Start a quiz').first);
    await tester.pumpAndSettle();
    expect(find.byType(QuizScreen), findsOneWidget);
    verify(() => mockRepository.fetchQuiz()).called(1);
  });
}
