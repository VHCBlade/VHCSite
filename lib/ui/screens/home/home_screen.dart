import 'package:event_essay/event_essay.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EssayScroll(
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: double.infinity),
          ),
          Center(child: _HomeContent())
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(children: [
        SelectableText(
          "Welcome to my Website!",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        SelectableText(
          "VHCBlade - Do what you're good at!",
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        Image.asset('assets/img/Logo.png'),
        Align(
            alignment: Alignment.centerRight,
            child: SelectableText(
              "Powered by Flutter",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
            )),
      ]),
    );
  }
}
