import 'package:flutter/material.dart';

class QuizHeaderImage extends StatelessWidget {
  final bool? hasWon;
  const QuizHeaderImage({
    super.key,
    required this.hasWon,
  });

  final double heightHeader = 130;

  @override
  Widget build(BuildContext context) {
    if (hasWon == null) {
      return Image.asset(
        'images/hot_air_balloons.png',
        height: heightHeader,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: heightHeader,
          child: Center(
            child: Text(
              // ignore: avoid-non-ascii-symbols
              hasWon == true ? 'Bravo ! 🥳' : '🤯 Try again',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
