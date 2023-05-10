import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/quiz_entry.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_item.dart';
import 'package:flutter_quiz/store/correct_answer_provider.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_test/flutter_test.dart';

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

  Widget mountQuizItem() {
    return CorrectAnswerProvider(
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Builder(builder: (context) {
                return Text(
                  'correct answers: ${CorrectAnswerStore.of(context).correctAnswers.toString()}',
                );
              }),
              QuizItem(
                quiz: createQuiz(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  testWidgets('QuizItem widget', (tester) async {
    await tester.pumpWidget(mountQuizItem());

    expect(find.text('correct answers: 0'), findsOneWidget);
    expect(find.text('0 $question'), findsOneWidget);
    await tester.tap(find.text('false'));
    await tester.pumpAndSettle();
    expect(find.text('correct answers: 1'), findsOneWidget);

    await tester.tap(find.text('Next').first);
    await tester.pumpAndSettle();

    expect(find.text('1 $question'), findsOneWidget);

    await tester.tap(find.text('false'));
    await tester.pumpAndSettle();
    expect(find.text('correct answers: 2'), findsOneWidget);

    await tester.tap(find.text('Next').first);
    await tester.pumpAndSettle();

    expect(find.text('2 $question'), findsOneWidget);

    await tester.tap(find.text('true'));
    await tester.pumpAndSettle();
    expect(find.text('correct answers: 2'), findsOneWidget);
  });
}
