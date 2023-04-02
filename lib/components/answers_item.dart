import 'package:flutter/material.dart';

class AnswersItem extends StatelessWidget {
  final String answer;
  final Function() onTap;
  final bool? isValid;
  const AnswersItem({
    super.key,
    required this.answer,
    required this.onTap,
    this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isValid == false
            ? BorderSide(color: errorColor, width: 3)
            : isValid == true
                ? const BorderSide(color: Colors.green, width: 3)
                : BorderSide.none,
      ),
      child: ListTile(
        leading: Icon(
          isValid == false
              ? Icons.close
              : isValid == true
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
        ),
        iconColor: isValid == false
            ? errorColor
            : isValid == true
                ? Colors.green
                : null,
        title: Text(answer),
        onTap: onTap,
      ),
    );
  }
}
