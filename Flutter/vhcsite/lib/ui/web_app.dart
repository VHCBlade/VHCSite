import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/model/navigation/navigation_model.dart';
import 'package:vhcsite/state/model_provider.dart';

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = context.watch<ModelNotifier<NavigationModel>>().model;

    final href = window.location.href;
    final path = href.substring(href.indexOf(_PATH) + _PATH.length);

    print(path);

    window.location.assign(
        href.substring(0, href.indexOf(_PATH) + _PATH.length) +
            model.navigationPath);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
