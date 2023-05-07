import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_item.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/screens/quiz_screen/score.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:provider/provider.dart';

import 'package:flutter_quiz/repository.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<QuizEntry>> _future;

  @override
  void initState() {
    _future = Provider.of<Repository>(context, listen: false).fetchQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: kBlueGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Score(),
          ),
          leadingWidth: 200,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Provider.of<CorrectAnswerStore>(context, listen: false)
                      .reset();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
          child: FutureBuilder(
            future: _future,
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
      ),
    );
  }
}
