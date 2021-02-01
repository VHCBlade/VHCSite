import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/state/event_channel.dart';

/// This is a page to hold all the rendering data on essay pages.

/// General parent for all text.
class EssayText extends StatelessWidget {
  final Widget child;

  const EssayText({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft, child: child);
  }
}

/// Display for the headers.
class EssayHeaderText extends StatelessWidget {
  final String text;

  const EssayHeaderText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EssayText(
        child:
            SelectableText(text, style: Theme.of(context).textTheme.headline3));
  }
}

/// Display for the general text of each paragraph
class EssayParagraphText extends StatelessWidget {
  final String text;

  const EssayParagraphText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EssayText(
        child: Text(text, style: Theme.of(context).textTheme.subtitle1));
  }
}

/// Display for links that go over everything.
class EssayLinkText extends StatelessWidget {
  final String link;
  final String text;

  const EssayLinkText({Key key, this.link, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EssayText(
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => _clickLink(link, context),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).highlightColor),
                ))));
  }
}

_clickLink(String link, BuildContext context) =>
    context.read<ProviderEventChannel>().fireEvent('url', link);

/// Currently there's a bug with Rich Text and not getting the URL to work.
/// So don't use this.
TextSpan createLinkTextSpan(String text, String link, BuildContext context,
    [List<TextSpan> children]) {
  final recognizer = TapGestureRecognizer();
  recognizer.onTap = () => _clickLink(link, context);

  return TextSpan(
    text: text,
    recognizer: recognizer,
    children: children,
    style: Theme.of(context).textTheme.subtitle1.copyWith(
        decoration: TextDecoration.underline,
        color: Theme.of(context).highlightColor),
  );
}

TextSpan createTextSpan(String text, BuildContext context,
    [List<TextSpan> children]) {
  return TextSpan(
    text: text,
    style: Theme.of(context).textTheme.subtitle1,
    children: children,
  );
}
