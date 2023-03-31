class QuizEntry {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuizEntry({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });
}
