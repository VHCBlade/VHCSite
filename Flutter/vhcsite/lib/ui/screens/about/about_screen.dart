import 'package:animations/animations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/navigation/navigation_model.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:vhcsite/ui/page/essay_page.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/ui/screens/about/changelog_screen.dart';

final equality = ListEquality();

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelNotifier<NavigationModel>>().model;

    late final Widget widget;

    if (equality.equals(model.subNavigation, const ["changelog"])) {
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
      FlatButton(
          onPressed: () => showLicensePage(context: context),
          color: Theme.of(context).primaryColor,
          child: Text("Licenses", style: Theme.of(context).textTheme.button)),
      FlatButton(
          onPressed: () => context
              .read<ProviderEventChannel>()
              .fireEvent(SUB_NAVIGATION_EVENT, "changelog"),
          color: Theme.of(context).primaryColor,
          child: Text("Changelog", style: Theme.of(context).textTheme.button))
    ]);
  }
}
