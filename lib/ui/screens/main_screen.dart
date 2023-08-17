import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_essay/event_essay.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:vhcblade_theme/vhcblade_widget.dart';
import 'package:vhcsite/config.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/bloc/app_size.dart';
import 'package:vhcsite/ui/appbar/appbar.dart';
import 'package:vhcsite/ui/screens/about/about_screen.dart';
import 'package:vhcsite/ui/screens/app/app_screen.dart';
import 'package:vhcsite/ui/screens/blog/blog_screen.dart';
import 'package:vhcsite/ui/screens/error/error_screen.dart';
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
      ),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  void initState() {
    super.initState();
    context
      ..fireEvent(VHCSiteEvent.loadApiVersion.event, null, withDelay: true)
      ..fireEvent(VHCSiteEvent.loadVersion.event, null, withDelay: true);
  }

  @override
  Widget build(BuildContext context) {
    final model =
        context.watch<BlocNotifier<MainNavigationBloc<String>>>().bloc;

    late final Widget widget;

    switch (model.currentMainNavigation) {
      case 'blog':
        context.fireEvent(VHCSiteEvent.loadBlog.event, null, withDelay: true);
        widget = const BlogScreen();
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

    return FadeThroughWidgetSwitcher(builder: (_) => widget);
  }
}
