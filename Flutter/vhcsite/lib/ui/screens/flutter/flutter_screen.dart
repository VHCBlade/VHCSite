import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/ui/page/essay_text.dart';
import 'package:vhcsite/widget/scrollbar_provider.dart';

class FlutterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollbarProvider(
        isAlwaysShown: true,
        builder: (controller, _) => Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                controller: controller,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1200),
                  padding: EdgeInsets.all(30),
                  child: FlutterPageContent(),
                ))));
  }
}

class FlutterPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      children: [
        HeaderText(text: "I Love Flutter!"),
        SelectableText.rich(
          createLinkTextSpan('Flutter', 'https://flutter.dev', context,
              [createTextSpan(' is awesome!', context)]),
        )
      ],
    );
  }
}
