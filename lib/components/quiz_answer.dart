import 'package:flutter/material.dart';

class QuizAnswer extends StatelessWidget {
  final String answer;
  final Function() onTap;
  final bool? invalid;
  const QuizAnswer({
    super.key,
    required this.answer,
    required this.onTap,
    this.invalid,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: invalid == true
            ? BorderSide(color: errorColor, width: 3)
            : invalid == false
                ? const BorderSide(color: Colors.green, width: 3)
                : BorderSide.none,
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          invalid == true
              ? Icons.close
              : invalid == false
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
        ),
        iconColor: invalid == true
            ? errorColor
            : invalid == false
                ? Colors.green
                : null,
        title: Text(answer),
        onTap: onTap,
      ),
    );
  }
}
