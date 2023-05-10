import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/quiz_entry.dart';
import 'package:flutter_quiz/repository/quiz_repository_provider.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_item.dart';
import 'package:flutter_quiz/screens/quiz_screen/score.dart';
import 'package:flutter_quiz/theme_constants.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // ignore: avoid-late-keyword
  late Future<List<QuizEntry>> fetchQuizRequest;

  @override
  void didChangeDependencies() {
    fetchQuizRequest = QuizRepositoryProvider.of(context).fetchQuiz();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ThemeConstants.blueGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Score(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leadingWidth: 200,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20.0),
          child: FutureBuilder(
            future: fetchQuizRequest,
            builder: (context, AsyncSnapshot<List<QuizEntry>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An error occurred while fetching the quiz.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                );
              }
              final quiz = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting ||
                  quiz == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(child: QuizItem(quiz: quiz));
            },
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
