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
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected == false ? Colors.white : null,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 3.0,
              spreadRadius: 0.0,
              offset: Offset(1.0, 3.0),
            )
          ],
          gradient: isSelected == false
              ? null
              : isValid == false
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 1],
                      colors: [
                        Color(0xFFF06F9F),
                        Color(0xFFED8C69),
                      ],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 1],
                      colors: [
                        Color(0xFFEFD701),
                        Color(0xFFB8BE08),
                      ],
                    ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            if (isSelected == true)
              Padding(
                padding: const EdgeInsets.only(right: 7.0),
                child: Icon(
                  isValid == true
                      ? Icons.check_circle_outline
                      : Icons.error_outline_outlined,
                  color: Colors.white,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 18),
                    child: Text(
                      answer,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isSelected == false
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
