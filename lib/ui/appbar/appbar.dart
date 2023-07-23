import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/events/events.dart';
import 'package:event_bloc/event_bloc.dart';
import 'package:vhcsite/ui/appbar/nav_button.dart';
import 'package:vhcsite/widget/textscale.dart';

const IMAGE_LOCATION = 'assets/img/LogoWithName.png';

PreferredSizeWidget createAppBar(BuildContext context, bool addActions) =>
    wrapInNoTextScale(
        AppBar(
            title: Image.asset(IMAGE_LOCATION,
                frameBuilder: (context, widget, frame, loaded) =>
                    loaded || frame != null
                        ? widget
                        : const CircularProgressIndicator(),
                height: 56),
            actions: addActions
                ? [
                    const NavButton(text: "Home", type: "home"),
                    const NavButton(text: "Apps", type: "apps"),
                    const NavButton(text: "Blog", type: "blog"),
                    const NavButton(text: "YouTube", type: "youtube"),
                    const NavButton(text: "About", type: "about"),
                    Container(width: 10)
                  ]
                : null),
        context);

class ActionDrawer extends StatelessWidget {
  const ActionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        final channel = BlocEventChannel(context.read<BlocEventChannel>());

        channel.addEventListener<String>(
            VHCSiteEvent.button.event, (_, val) => Navigator.pop(context));

        return channel;
      },
      child: SizedBox(
        width: 240,
        child: Drawer(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  color: Theme.of(context).primaryColor,
                  child: Image.asset(IMAGE_LOCATION)),
              const DrawerPortion()
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerPortion extends StatelessWidget {
  const DrawerPortion({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Column(children: [
      DrawerButton(text: "Home", type: "home"),
      DrawerButton(text: "Apps", type: "apps"),
      DrawerButton(text: "Blog", type: "blog"),
      DrawerButton(text: "YouTube", type: "youtube"),
      DrawerButton(text: "About", type: "about"),
    ]));
  }
}

class DrawerButton extends StatelessWidget {
  final String text;
  final String type;

  const DrawerButton({Key? key, required this.text, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: NavButton(
        text: text,
        type: type,
        afterNavigation: (context) => Navigator.of(context).pop(),
      ),
    );
  }
}
