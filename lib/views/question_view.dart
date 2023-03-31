import 'package:flutter/material.dart';
import 'package:flutter_quiz/layout.dart';
import 'package:flutter_quiz/views/result_view.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('1 of 10 Question'),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'What does a funambulist walk on?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.check_box_outline_blank,
                ),
                title: const Text('Broken Glass'),
                onTap: () {},
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.green, width: 3),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.check_box_outlined,
                ),
                iconColor: Colors.green,
                title: const Text('A tight rope'),
                onTap: () {},
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.error, width: 3),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.close,
                ),
                iconColor: Theme.of(context).colorScheme.error,
                title: const Text('The moon'),
                onTap: () {},
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.check_box_outline_blank,
                ),
                title: const Text('Balls'),
                onTap: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 15),
                  child: ElevatedButton(
                    child: const Text('Next'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResultView(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
