import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/state/event_channel.dart';

class EssayText extends StatelessWidget {
  final Widget child;

  const EssayText({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft, child: child);
  }
}

class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EssayText(
        child:
            SelectableText(text, style: Theme.of(context).textTheme.headline3));
  }
}

_clickLink(String link, BuildContext context) =>
    Provider.of<ProviderEventChannel>(context, listen: false)
        .fireEvent('url', link);

Widget createLinkText(String text, String link, BuildContext context) {
  return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () => _clickLink(link, context),
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                decoration: TextDecoration.underline,
                color: Theme.of(context).highlightColor),
          )));
}

Widget createText(String text, BuildContext context) {
  return Text(text, style: Theme.of(context).textTheme.subtitle1);
}

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
