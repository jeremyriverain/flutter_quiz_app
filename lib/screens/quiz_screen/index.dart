import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/quiz_screen/quiz_item.dart';
import 'package:flutter_quiz/constants.dart';
import 'package:flutter_quiz/model.dart';
import 'package:flutter_quiz/repository.dart';
import 'package:flutter_quiz/store/correct_answer_store.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  final Repository quizRepository = Repository();

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
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<CorrectAnswerStore>(context, listen: false).reset();
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: FutureBuilder(
              future: quizRepository.fetchQuiz(),
              builder: (context, AsyncSnapshot<List<QuizEntry>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'An error occured while fetching the quiz.',
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
              }),
        ),
      ),
    );
  }
}
