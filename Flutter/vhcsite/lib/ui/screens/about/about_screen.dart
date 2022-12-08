import 'package:animations/animations.dart';
import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/ui/page/essay_page.dart';
import 'package:vhcsite/ui/screens/about/changelog_screen.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watchBloc<MainNavigationBloc<String>>();

    late final Widget widget;

    if (model.currentDeepNavigation?.value == "changelog") {
      widget = ChangelogScreen();
    } else {
      widget = AboutHomeScreen();
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

class AboutHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EssayScreen(path: [
      'about'
    ], trailing: [
      TextButton(
          onPressed: () => showLicensePage(context: context),
          // color: Theme.of(context).primaryColor,
          child: Text("Licenses", style: Theme.of(context).textTheme.button)),
      TextButton(
          onPressed: () => context.pushDeepNavigation("changelog"),
          // color: Theme.of(context).primaryColor,
          child: Text("Changelog", style: Theme.of(context).textTheme.button))
    ]);
  }
}
