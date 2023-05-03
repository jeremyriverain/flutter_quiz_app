import 'package:flutter/material.dart';
import 'package:flutter_quiz/constants.dart';

class QuizAnswer extends StatelessWidget {
  final String answer;
  final Function() onTap;
  final bool isSelected;
  final bool isValid;
  const QuizAnswer({
    super.key,
    required this.answer,
    required this.onTap,
    required this.isSelected,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: isSelected == false ? Colors.white : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          kBoxShadow,
        ],
        gradient: isSelected == false
            ? null
            : isValid == false
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1],
                    colors: [
                      Color(0xFFF06F9F),
                      Color(0xFFED8C69),
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 1],
                    colors: [
                      Color(0xFFEFD701),
                      Color(0xFFB8BE08),
                    ],
                  ),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          answer,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isSelected == false
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
