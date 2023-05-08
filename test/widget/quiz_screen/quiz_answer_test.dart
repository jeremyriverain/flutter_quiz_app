import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_answer.dart';
import 'package:flutter_quiz/theme_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizAnswer widget', () {
    testWidgets('not selected answer', (tester) async {
      int count = 0;
      const answer = 'this is an answer';
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: QuizAnswer(
            answer: answer,
            onTap: () {
              count++;
            },
            isSelected: false,
            isValid: false,
          ),
        ),
      ));

      expect(find.text(answer), findsOneWidget);
      expect(count, 0);
      await tester.tap(find.byType(QuizAnswer));
      expect(count, 1);
      expect(
        (find.byType(Ink).evaluate().first.widget as Ink).decoration,
        equals(
          const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              ThemeConstants.boxShadow,
            ],
          ),
        ),
      );
    });

    testWidgets('valid answer', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: QuizAnswer(
            answer: 'this is a valid answer',
            onTap: () {},
            isSelected: true,
            isValid: true,
          ),
        ),
      ));

      expect(
        ((find.byType(Ink).evaluate().first.widget as Ink).decoration
                as BoxDecoration)
            .gradient,
        equals(ThemeConstants.successGradient),
      );
    });

    testWidgets('invalid answer', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: QuizAnswer(
            answer: 'this is an invalid answer',
            onTap: () {},
            isSelected: true,
            isValid: false,
          ),
        ),
      ));

      expect(
        ((find.byType(Ink).evaluate().first.widget as Ink).decoration
                as BoxDecoration)
            .gradient,
        equals(
          ThemeConstants.errorGradient,
        ),
      );
    });
  });
}
