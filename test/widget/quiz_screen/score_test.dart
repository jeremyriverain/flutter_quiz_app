import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/score.dart';
import 'package:flutter_quiz/stores/correct_answer_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Score widget shows score appropriately', (tester) async {
    final correctAnswerStore = CorrectAnswerStore();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => correctAnswerStore),
        ],
        child: const MaterialApp(home: Score()),
      ),
    );

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    correctAnswerStore.increment();
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
  });
}
