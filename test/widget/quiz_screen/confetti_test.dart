import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/confetti.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Confetti widget uses ConfettiWidget appropriately',
    (tester) async {
      final controllerBottomCenter =
          ConfettiController(duration: const Duration(seconds: 5));
      await tester.pumpWidget(MaterialApp(
        home: Confetti(
          controller: controllerBottomCenter,
        ),
      ));

      expect(find.byType(ConfettiWidget), findsOneWidget);

      expect(
        (find.byType(ConfettiWidget).evaluate().first.widget as ConfettiWidget)
            .confettiController,
        equals(
          controllerBottomCenter,
        ),
      );
    },
  );
}
