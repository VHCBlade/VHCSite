import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/model/environment.dart';
import 'package:vhcsite/ui/bloc_builders.dart';
import 'package:vhcsite/ui/repository_builders.dart';
import 'package:vhcsite/ui/screens/main_screen.dart';
import 'package:vhcsite/ui/theme/theme.dart';
import 'package:vhcsite/ui/watcher/watcher.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => const VHCEnvironment(),
      child: MultiRepositoryProvider(
        repositoryBuilders: repositoryBuilders,
        child: MultiBlocProvider(
          blocBuilders: blocBuilders,
          child: WatcherLayer(child: _InnerApp()),
        ),
      ),
    );
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
                builder: (_) => const MainScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
