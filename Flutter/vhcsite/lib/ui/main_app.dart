import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vhcsite/model/app_size_model.dart';
import 'package:vhcsite/model/navigation/navigation_model.dart';
import 'package:vhcsite/model/url_model.dart';
import 'package:vhcsite/ui/screens/main_screen.dart';
import 'package:vhcsite/ui/theme/theme.dart';
import 'package:vhcsite/state/model_provider.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelProvider(
      create: (_, channel) => AppSizeModel(parentChannel: channel),
      child: ModelProvider(
        create: (_, channel) => UrlModel(parentChannel: channel),
        child: ModelProvider(
          create: (_, channel) => NavigationModel(parentChannel: channel),
          child: MaterialApp(
              title: 'VHCBlade', theme: createTheme(), home: MainScreen()),
        ),
      ),
    );
  }
}
