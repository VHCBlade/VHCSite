import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/app_size_model.dart';
import 'package:vhcsite/model/navigation/navigation_model.dart';
import 'package:vhcsite/model/url_model.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/ui/screens/main_screen.dart';
import 'package:vhcsite/ui/theme/theme.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:vhcsite/ui/web_app.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelProvider(
        create: (_, channel) {
          final model = AppSizeModel(parentChannel: channel);
          model.modelUpdated.add(() => print("Hey"));
          return model;
        },
        child: ModelProvider(
          create: (_, channel) => UrlModel(parentChannel: channel),
          child: ModelProvider(
              create: (_, channel) => NavigationModel(parentChannel: channel),
              child: _InnerApp()),
        ));
  }
}

class _InnerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'VHCBlade',
        theme: createTheme(),
        onGenerateInitialRoutes: (path) =>
            [MaterialPageRoute(builder: (_) => MainScreen())],
        onGenerateRoute: (settings) {
          if (settings.name != null) {
            context
                .read<ProviderEventChannel>()
                .fireEvent(MAIN_NAVIGATION_EVENT, settings.name!.substring(1));
          }
          return null;
        },
        builder: (_, child) =>
            kIsWeb ? WebAppNavHandler(child: child!) : child!);
  }
}
