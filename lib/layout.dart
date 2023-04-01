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
            flex: 1,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          body,
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
