import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/navigation/navigation_model.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model_provider.dart';

// TODO Replace with Universal HTML Eventually
import 'dart:html';

const _PATH = "/#/";

/// Adds NavigationHandling to App
class WebAppNavHandler extends StatefulWidget {
  final Widget child;

  const WebAppNavHandler({Key? key, required this.child}) : super(key: key);

  @override
  _WebAppNavHandlerState createState() => _WebAppNavHandlerState();
}

class _WebAppNavHandlerState extends State<WebAppNavHandler> {
  @override
  void initState() {
    super.initState();
    final href = window.location.href;
    final path = href.substring(href.indexOf(_PATH) + _PATH.length);

    context.read<ProviderEventChannel>().fireEvent(MAIN_NAVIGATION_EVENT, path);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = context.watch<ModelNotifier<NavigationModel>>().model;

    final href = window.location.href;
    final path = href.substring(href.indexOf(_PATH) + _PATH.length);

    final fullNavigation = model.fullNavigation;
    // Skip if the path is the same.
    if (path == fullNavigation) {
      return;
    }

    window.location.assign(
        href.substring(0, href.indexOf(_PATH) + _PATH.length) + fullNavigation);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
