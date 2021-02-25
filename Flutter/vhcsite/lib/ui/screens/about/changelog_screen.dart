import 'package:flutter/material.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/ui/page/essay_page.dart';
import 'package:provider/provider.dart';

class ChangelogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EssayScreen(leading: [
      FlatButton(
          onPressed: () => context
              .read<ProviderEventChannel>()
              .fireEvent(SUB_NAVIGATION_EVENT, "back"),
          color: Theme.of(context).primaryColor,
          child: Text("Back", style: Theme.of(context).textTheme.button)),
    ], path: [
      'about'
    ]);
  }
}
