import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_essay/event_essay.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/bloc/version.dart';
import 'package:vhcsite/ui/page/refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WebRefresh(
      child: EssayScroll(
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
            ),
            const Center(child: _HomeContent())
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final version = context.watchBloc<VersionBloc>().version;
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
