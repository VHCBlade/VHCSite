import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/bloc/app_size.dart';
import 'package:vhcsite/bloc/navigation/navigation_bloc.dart';
import 'package:vhcsite/repository/url_repository.dart';
import 'package:vhcsite/ui/screens/main_screen.dart';
import 'package:vhcsite/ui/theme/theme.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => UrlRepository(),
        child: BlocProvider(
          create: (_, channel) => AppSizeBloc(parentChannel: channel),
          child: BlocProvider(
              create: (_, channel) => generateNavigationBloc(channel),
              child: _InnerApp()),
        ));
  }
}

class _InnerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EventNavigationApp(
      title: 'VHCBlade',
      theme: createSiteTheme(),
      builder: (_) => Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (_) => MainScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
