import 'package:flutter/material.dart';
import 'package:vhcsite/ui/page/essay_page.dart';

class FlutterScreen extends StatelessWidget {
  const FlutterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EssayScreen(leading: [
      Text("Flutter State Management",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).primaryColor)),
    ], path: const [
      'dev',
      'flutter',
      'state'
    ]);
  }
}
