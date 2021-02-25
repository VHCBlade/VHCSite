import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/state/event_channel.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final String type;
  final bool disabled;

  const DefaultButton(
      {Key? key, required this.text, required this.type, this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(text, style: Theme.of(context).textTheme.button),
        disabledColor: Theme.of(context).disabledColor,
        onPressed: disabled
            ? null
            : () =>
                context.read<ProviderEventChannel>().fireEvent("button", type));
  }
}

class VHCBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () => context
            .read<ProviderEventChannel>()
            .fireEvent(SUB_NAVIGATION_EVENT, "back"),
        color: Theme.of(context).primaryColor,
        child: Text("Back", style: Theme.of(context).textTheme.button));
  }
}
