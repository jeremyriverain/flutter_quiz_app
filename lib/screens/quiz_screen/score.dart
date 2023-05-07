import 'package:flutter/material.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:provider/provider.dart';

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      key: const Key('score'),
      children: <Widget>[
        Container(
          height: 40.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            border: Border.all(color: Colors.white, width: 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events_outlined,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                Provider.of<CorrectAnswerStore>(context, listen: true)
                    .correctAnswers
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
