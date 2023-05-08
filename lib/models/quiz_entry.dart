class QuizEntry {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuizEntry({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuizEntry.fromJSON(Map<String, dynamic> json) {
    return QuizEntry(
      question: Uri.decodeComponent(json['question']),
      correctAnswer: Uri.decodeComponent(json['correct_answer']),
      incorrectAnswers: List<String>.from(json['incorrect_answers'])
          .map((e) => Uri.decodeComponent(e))
          .toList(),
    );
  }
}
