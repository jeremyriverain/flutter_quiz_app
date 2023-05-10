import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/score.dart';
import 'package:flutter_quiz/store/correct_answer_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Score widget shows score appropriately', (tester) async {
    await tester.pumpWidget(
      CorrectAnswerProvider(
        child: MaterialApp(
          home: Column(
            children: [
              Builder(builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    CorrectAnswerProvider.of(context).increment();
                  },
                  child: const Text('increment'),
                );
              }),
              const Score(),
            ],
          ),
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.text('increment'));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
  });
}
