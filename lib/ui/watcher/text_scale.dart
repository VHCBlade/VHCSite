import 'package:flutter/material.dart';
import 'package:vhcsite/model/environment.dart';

class TextScaleWatcher extends StatelessWidget {
  final Widget child;

  const TextScaleWatcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (context.environment.overrideTextScale) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: child,
      );
    }
    return child;
  }
}
