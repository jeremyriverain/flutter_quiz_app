import 'package:flutter/material.dart';
import 'package:flutter_quiz/theme_constants.dart';

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

  Gradient? getGradient() {
    if (!isSelected) {
      return null;
    }

    return !isValid
        ? ThemeConstants.errorGradient
        : ThemeConstants.successGradient;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: !isSelected ? Colors.white : null,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          ThemeConstants.boxShadow,
        ],
        gradient: getGradient(),
      ),
      child: ListTile(
        title: Text(
          answer,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color:
                    !isSelected ? Theme.of(context).primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        onTap: onTap,
      ),
    );
  }
}
