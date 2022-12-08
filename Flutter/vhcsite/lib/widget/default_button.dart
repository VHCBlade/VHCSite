import 'package:flutter/material.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:vhcsite/events/events.dart';
import 'package:event_bloc/event_bloc_widgets.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final String type;
  final bool disabled;
  final void Function()? onPressedOverride;

  const DefaultButton(
      {Key? key,
      required this.text,
      required this.type,
      this.disabled = false,
      this.onPressedOverride})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(text, style: Theme.of(context).textTheme.button),
        onPressed: disabled
            ? null
            : onPressedOverride ??
                () => context.fireEvent<String>(UIEvent.button.event, type));
  }
}

class VHCBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => context.popDeepNavigation(),
        // color: Theme.of(context).primaryColor,
        child: Text("Back", style: Theme.of(context).textTheme.button));
  }
}
