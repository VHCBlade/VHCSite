import 'package:event_essay/event_essay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart';

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

class _HomeContent extends StatefulWidget {
  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  String? version;

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/VERSION')
        .then((value) => setState(() => version = value));
  }

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
        Row(
          children: [
            if (version != null)
              SelectableText(
                "v$version",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.left,
              ),
            const Expanded(child: SizedBox()),
            SelectableText(
              "Powered by Flutter",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
            )
          ],
        ),
        if (kIsWeb)
          ElevatedButton(
            onPressed: () => window.location.reload(),
            child: const Text('Force Refresh Page'),
          )
      ]),
    );
  }
}
