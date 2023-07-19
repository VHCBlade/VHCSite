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
        onPressed: disabled
            ? null
            : onPressedOverride ??
                () => context.fireEvent<String>(UIEvent.button.event, type),
        child: Text(text));
  }
}

class VHCBackButton extends StatelessWidget {
  const VHCBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => context.popDeepNavigation(),
        child: const Text("Back"));
  }
}
