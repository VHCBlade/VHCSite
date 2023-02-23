import 'package:animations/animations.dart';
import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/ui/page/essay_page.dart';
import 'package:vhcsite/ui/screens/about/changelog_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watchBloc<MainNavigationBloc<String>>();

    late final Widget widget;

    if (model.currentDeepNavigation?.value == "changelog") {
      widget = const ChangelogScreen();
    } else {
      widget = const AboutHomeScreen();
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

class AboutHomeScreen extends StatelessWidget {
  const AboutHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EssayScreen(path: const [
      'about',
      'about'
    ], trailing: [
      ElevatedButton(
          onPressed: () => showLicensePage(context: context),
          child: const Text("Licenses")),
      ElevatedButton(
          onPressed: () => context.pushDeepNavigation("changelog"),
          child: const Text("Changelog"))
    ]);
  }
}
