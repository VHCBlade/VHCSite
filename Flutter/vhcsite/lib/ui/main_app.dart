import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/app_size_model.dart';
import 'package:vhcsite/model/navigation/navigation_bloc.dart';
import 'package:vhcsite/repository/url_repository.dart';
import 'package:vhcsite/ui/screens/main_screen.dart';
import 'package:vhcsite/ui/theme/theme.dart';
import 'package:vhcsite/ui/web_app.dart';
import 'package:provider/provider.dart';
import 'package:event_bloc/event_bloc.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => UrlRepository(),
        child: BlocProvider(
          create: (_, channel) => AppSizeBloc(parentChannel: channel),
          child: BlocProvider(
              create: (_, channel) => NavigationBloc(parentChannel: channel),
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
                .read<BlocEventChannel>()
                .fireEvent(MAIN_NAVIGATION_EVENT, settings.name!.substring(1));
          }
          return null;
        },
        builder: (_, child) =>
            kIsWeb ? WebAppNavHandler(child: child!) : child!);
  }
}
