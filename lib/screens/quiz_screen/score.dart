import 'package:flutter/material.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('score'),
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.white, width: 1.0),
            ),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          width: 60.0,
          height: 40.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.emoji_events_outlined,
              size: 28,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              CorrectAnswerStore.of(context).correctAnswers.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ],
    );
  }
}
