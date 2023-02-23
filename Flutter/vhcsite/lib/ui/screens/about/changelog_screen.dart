import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vhcsite/ui/page/essay_page.dart';
import 'package:vhcsite/ui/page/essay_text.dart';
import 'package:vhcsite/widget/default_button.dart';

class ChangelogScreen extends StatefulWidget {
  @override
  _ChangelogScreenState createState() => _ChangelogScreenState();
}

class _ChangelogScreenState extends State<ChangelogScreen> {
  String? changelog;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('CHANGELOG.md').then((value) {
      setState(() => changelog = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EssayScroll(
        child: Wrap(runSpacing: 10, spacing: 10, children: [
      Container(width: double.infinity),
      VHCBackButton(),
      changelog == null
          ? CircularProgressIndicator()
          : EssayParagraphText(text: changelog!)
    ]));
  }
}
