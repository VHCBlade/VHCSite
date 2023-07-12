import 'package:event_essay/event_essay.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EssayScroll(
      child: Text(
        'Could not find the page you are looking for.',
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
