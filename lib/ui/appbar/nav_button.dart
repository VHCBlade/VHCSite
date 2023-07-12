import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/widget/default_button.dart';
import 'package:event_bloc/event_bloc_widgets.dart';

class NavButton extends StatelessWidget {
  final String text;
  final String type;
  final void Function(BuildContext)? afterNavigation;

  const NavButton(
      {Key? key, required this.text, required this.type, this.afterNavigation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watchBloc<MainNavigationBloc<String>>();
    return SizedBox(
      width: 85,
      child: DefaultButton(
        text: text,
        type: type,
        disabled: type == bloc.currentMainNavigation,
        onPressedOverride: type == "youtube"
            ? null
            : () {
                context.changeMainNavigation(type);
                if (afterNavigation != null) {
                  afterNavigation!(context);
                }
              },
      ),
    );
  }
}
