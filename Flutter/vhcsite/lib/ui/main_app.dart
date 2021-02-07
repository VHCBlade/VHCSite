import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vhcsite/model/app_size_model.dart';
import 'package:vhcsite/model/navigation_model.dart';
import 'package:vhcsite/model/url_model.dart';
import 'package:vhcsite/ui/screens/main_screen.dart';
import 'package:vhcsite/ui/theme.dart';
import 'package:vhcsite/state/model_provider.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VHCBlade',
      theme: createTheme(),
      home: ModelProvider(
          builder: (_, channel) => AppSizeModel(parentChannel: channel),
          child: ModelProvider(
              builder: (_, channel) => UrlModel(parentChannel: channel),
              child: ModelProvider(
                  builder: (_, channel) =>
                      NavigationModel(parentChannel: channel),
                  child: MainScreen()))),
    );
  }
}
