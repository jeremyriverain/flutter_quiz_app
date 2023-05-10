import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_header_image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizHeaderImage widget', () {
    testWidgets('has not ended quiz', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: QuizHeaderImage(
          hasWon: null,
        ),
      ));

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('has won', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: QuizHeaderImage(
          hasWon: true,
        ),
      ));

      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Bravo'), findsOneWidget);
    });

    testWidgets('has failed', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: QuizHeaderImage(
          hasWon: false,
        ),
      ));

      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });
  });
}
