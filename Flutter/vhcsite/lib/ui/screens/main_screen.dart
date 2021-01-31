import 'package:flutter/material.dart';
import 'package:vhcsite/model/navigation_model.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:vhcsite/ui/appbar/appbar.dart';
import 'package:vhcsite/ui/screens/flutter/flutter_screen.dart';
import 'package:vhcsite/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context),
      body: MainBody(),
    );
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelNotifier<NavigationModel>>().model;

    if (model.navigationPath == 'flutter') {
      return FlutterScreen();
    }
    return HomeScreen();
  }
}
