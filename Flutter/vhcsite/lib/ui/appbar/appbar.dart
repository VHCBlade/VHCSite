import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/state/event_channel.dart';
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
                        : CircularProgressIndicator(),
                height: 56),
            actions: addActions
                ? [
                    NavButton(text: "Home", type: "home"),
                    NavButton(text: "Software", type: "dev"),
                    NavButton(text: "YouTube", type: "youtube"),
                    NavButton(text: "About", type: "about"),
                    Container(width: 10)
                  ]
                : null),
        context);

class ActionDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        final channel =
            ProviderEventChannel(context.read<ProviderEventChannel>());

        channel.addEventListener(BUTTON_EVENT, (val) {
          Navigator.pop(context);
          return false;
        });

        return channel;
      },
      child: SizedBox(
        width: 240,
        child: Drawer(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(IMAGE_LOCATION),
                  color: Theme.of(context).primaryColor),
              DrawerPortion()
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      DrawerButton(text: "Home", type: "home"),
      DrawerButton(text: "Software", type: "dev"),
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
      constraints: BoxConstraints(minWidth: double.infinity),
      child: NavButton(text: text, type: type),
    );
  }
}
