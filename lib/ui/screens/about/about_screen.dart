import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_essay/event_essay.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhcblade_theme/vhcblade_widget.dart';
import 'package:vhcsite/ui/page/refresh.dart';
import 'package:vhcsite/ui/screens/about/changelog_screen.dart';

final _dateFormatter = DateFormat('yyyy-MM');

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

    return FadeThroughWidgetSwitcher(builder: (_) => widget);
  }
}

class AboutHomeScreen extends StatelessWidget {
  const AboutHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WebRefresh(
      child: EssayScreen(
        path: const ['about', 'about'],
        trailing: [
          ElevatedButton(
              onPressed: () => showLicensePage(context: context),
              child: const Text("Licenses")),
          ElevatedButton(
              onPressed: () => context.pushDeepNavigation("changelog"),
              child: const Text("Changelog")),
          ElevatedButton(
              onPressed: () => context.fireEvent(EssayEvent.url.event,
                  'https://vhcblade.com/resume.pdf?${_dateFormatter.format(DateTime.now())}'),
              child: const Text("Resume")),
        ],
      ),
    );
  }
}
