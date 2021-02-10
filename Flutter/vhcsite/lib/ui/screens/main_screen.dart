import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/app_size_model.dart';
import 'package:vhcsite/model/navigation/navigation_model.dart';
import 'package:vhcsite/repository/text_repository/default.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:vhcsite/ui/appbar/appbar.dart';
import 'package:vhcsite/ui/screens/about/about_screen.dart';
import 'package:vhcsite/ui/screens/flutter/flutter_screen.dart';
import 'package:vhcsite/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration()).then((value) => context
        .read<ProviderEventChannel>()
        .fireEvent(MEDIA_QUERY_EVENT, MediaQuery.of(context)));

    final model = context.watch<ModelNotifier<AppSizeModel>>().model;

    return Provider<TextRepository>(
        create: (_) => DefaultTextRepository(),
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
    final model = context.watch<ModelNotifier<NavigationModel>>().model;

    late final Widget widget;

    switch (model.navigationPath) {
      case 'flutter':
        widget = FlutterScreen();
        break;
      case 'about':
        widget = AboutScreen();
        break;
      case 'home':
      default:
        widget = HomeScreen();
    }

    return PageTransitionSwitcher(
        duration: Duration(milliseconds: 500),
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
