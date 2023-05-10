import 'package:flutter/material.dart';
import 'package:flutter_quiz/store/correct_answer_provider.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CorrectAnswerProvider mountStore() {
    return CorrectAnswerProvider(
      child: MaterialApp(
        home: Builder(builder: (BuildContext context) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  CorrectAnswerProvider.of(context).increment();
                },
                child: const Text('increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  CorrectAnswerProvider.of(context).reset();
                },
                child: const Text('reset'),
              ),
              Text(
                'correct answers: ${CorrectAnswerStore.of(context).correctAnswers.toString()}',
              ),
            ],
          );
        }),
      ),
    );
  }

  testWidgets('CorrectAnswerProvider', (tester) async {
    await tester.pumpWidget(mountStore());

    expect(find.text('correct answers: 0'), findsOneWidget);

    await tester.tap(find.text('increment'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('increment'));
    await tester.pumpAndSettle();

    expect(find.text('correct answers: 2'), findsOneWidget);

    await tester.tap(find.text('reset'));
    await tester.pumpAndSettle();

    expect(find.text('correct answers: 0'), findsOneWidget);
  });
}
