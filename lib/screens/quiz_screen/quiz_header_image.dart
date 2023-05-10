import 'package:flutter/material.dart';
import 'package:flutter_quiz/theme_constants.dart';

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

    final gradient = hasWon == true
        ? ThemeConstants.successGradient
        : ThemeConstants.errorGradient;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => gradient.createShader(bounds),
          child: Icon(
            hasWon == true ? Icons.check_circle_outline : Icons.close,
            size: 130,
            color: Colors.white,
          ),
        ),
        Text(
          hasWon == true ? 'Bravo' : 'Try again',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
