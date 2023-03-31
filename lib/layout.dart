import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget body;
  const Layout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          body,
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
