import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/quiz_entry.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_item.dart';
import 'package:flutter_quiz/stores/correct_answer_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  String question = '- is the earth flat ?';
  List<QuizEntry> createQuiz() {
    return List.generate(
      3,
      (index) => QuizEntry(
        question: '$index $question',
        correctAnswer: 'false',
        incorrectAnswers: ['maybe', 'true', 'why not'],
      ),
    );
  }

  late CorrectAnswerStore correctAnswerStore = CorrectAnswerStore();

  setUp(
    () => correctAnswerStore.reset(),
  );

  Widget mountQuizItem() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => correctAnswerStore),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: QuizItem(
            quiz: createQuiz(),
          ),
        ),
      ),
    );
  }

  testWidgets('QuizItem widget', (tester) async {
    await tester.pumpWidget(mountQuizItem());

    expect(correctAnswerStore.correctAnswers, equals(0));
    expect(find.text('0 $question'), findsOneWidget);
    await tester.tap(find.text('false'));
    await tester.pumpAndSettle();
    expect(correctAnswerStore.correctAnswers, equals(1));

    await tester.tap(find.text('Next').first);
    await tester.pumpAndSettle();

    expect(find.text('1 $question'), findsOneWidget);

    await tester.tap(find.text('false'));
    await tester.pumpAndSettle();
    expect(correctAnswerStore.correctAnswers, equals(2));

    await tester.tap(find.text('Next').first);
    await tester.pumpAndSettle();

    expect(find.text('2 $question'), findsOneWidget);

    await tester.tap(find.text('true'));
    await tester.pumpAndSettle();
    expect(correctAnswerStore.correctAnswers, equals(2));
  });
}
