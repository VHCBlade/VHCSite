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
import 'package:vhcsite/ui/screens/error/error_screen.dart';
import 'package:vhcsite/ui/screens/flutter/flutter_screen.dart';
import 'package:vhcsite/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
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
          body: MainBody(),
          drawer: model.showState == 1 ? null : ActionDrawer(),
        ));
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model =
        context.watch<BlocNotifier<MainNavigationBloc<String>>>().bloc;

    late final Widget widget;

    switch (model.currentMainNavigation) {
      case 'dev':
        widget = FlutterScreen();
        break;
      case 'about':
        widget = AboutScreen();
        break;
      case 'error':
        widget = ErrorScreen();
        break;
      case 'home':
      default:
        widget = HomeScreen();
    }

    return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) =>
            FadeThroughTransition(
              child: child,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
            ),
        child: widget);
  }
}
