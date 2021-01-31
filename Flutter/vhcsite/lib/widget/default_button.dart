import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/state/event_channel.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final String type;
  final bool disabled;

  const DefaultButton(
      {Key key, @required this.text, @required this.type, this.disabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(text, style: Theme.of(context).textTheme.button),
        disabledColor: Theme.of(context).disabledColor,
        onPressed: disabled
            ? null
            : () => Provider.of<EventChannel>(context, listen: false)
                .fireEvent("button", type));
  }
}
