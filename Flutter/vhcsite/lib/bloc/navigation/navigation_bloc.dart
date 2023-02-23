import 'package:event_navigation/event_navigation.dart';
import 'package:event_bloc/event_bloc.dart';
import 'package:vhcsite/bloc/navigation/inner/navigations.dart';

const POSSIBLE_NAVIGATIONS = <String>{"home", "dev", "about", "error"};

MainNavigationBloc<String> generateNavigationBloc(
    BlocEventChannel? parentChannel) {
  return MainNavigationBloc<String>(
    parentChannel: parentChannel,
    strategy: ListNavigationStrategy(
        possibleNavigations: POSSIBLE_NAVIGATIONS.toList(),
        navigationOnError: "error",
        defaultNavigation: "home"),
    undoStrategy: UndoRedoMainNavigationStrategy(),
  )..deepNavigationStrategyMap["about"] = AboutDeepNavigationStrategy();
}
