import 'package:animations/animations.dart';
import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/config.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/bloc/app_size.dart';
import 'package:vhcsite/repository/text_repository/default.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:vhcsite/ui/appbar/appbar.dart';
import 'package:vhcsite/ui/screens/about/about_screen.dart';
import 'package:vhcsite/ui/screens/app/app_screen.dart';
import 'package:vhcsite/ui/screens/error/error_screen.dart';
import 'package:vhcsite/ui/screens/flutter/flutter_screen.dart';
import 'package:vhcsite/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.fireEvent<MediaQueryData>(
        DataEvent.mediaQuery.event, MediaQuery.of(context)));

    final model = context.watch<BlocNotifier<AppSizeBloc>>().bloc;

    return Provider<TextRepository>(
        create: (_) => CURRENT_CONFIG == RunConfig.debug
            ? DelayedDefaultTextRepository()
            : DefaultTextRepository(),
        child: Scaffold(
          appBar: createAppBar(context, model.showState == 1),
          body: const MainBody(),
          drawer: model.showState == 1 ? null : const ActionDrawer(),
        ));
  }
}

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model =
        context.watch<BlocNotifier<MainNavigationBloc<String>>>().bloc;

    late final Widget widget;

    switch (model.currentMainNavigation) {
      case 'dev':
        widget = const FlutterScreen();
        break;
      case 'about':
        widget = const AboutScreen();
        break;
      case 'error':
        widget = const ErrorScreen();
        break;
      case 'apps':
        widget = const AppsScreen();
        break;
      case 'home':
      default:
        widget = const HomeScreen();
    }

    return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) =>
            FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            ),
        child: widget);
  }
}
