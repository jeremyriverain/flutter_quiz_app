import 'package:flutter/material.dart';

class AnswersItem extends StatelessWidget {
  final String answer;
  final Function() onTap;
  final bool isSelected;
  final bool isValid;
  const AnswersItem({
    super.key,
    required this.answer,
    required this.onTap,
    required this.isSelected,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isSelected == false
            ? BorderSide.none
            : isValid == false
                ? BorderSide(color: errorColor, width: 3)
                : const BorderSide(color: Colors.green, width: 3),
      ),
      child: ListTile(
        iconColor: isSelected == false
            ? null
            : isValid == false
                ? errorColor
                : Colors.green,
        title: Text(
          answer,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
          textAlign: TextAlign.center,
        ),
        onTap: onTap,
      ),
    );
  }
}
