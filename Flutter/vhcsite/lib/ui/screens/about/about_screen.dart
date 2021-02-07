import 'package:flutter/material.dart';
import 'package:vhcsite/ui/page/essay_page.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EssayScreen(path: [
      'about'
    ], trailing: [
      FlatButton(
          onPressed: () => showLicensePage(context: context),
          color: Theme.of(context).primaryColor,
          child: Text("Licenses", style: Theme.of(context).textTheme.button))
    ]);
  }
}
