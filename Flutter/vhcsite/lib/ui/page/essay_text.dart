import 'package:flutter/material.dart';

/// This is a page to hold all the rendering data on essay pages.

/// General parent for all text.
class EssayText extends StatelessWidget {
  final Widget child;

  const EssayText({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft, child: child);
  }
}

class EssayTitleText extends StatelessWidget {
  final String text;

  const EssayTitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EssayText(
        child: SelectableText(text,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Theme.of(context).primaryColor)));
  }
}

/// Display for the general text of each paragraph
class EssayParagraphText extends StatelessWidget {
  final String text;

  const EssayParagraphText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EssayText(
        child: Text(text, style: Theme.of(context).textTheme.titleMedium));
  }
}
