import 'package:vhcsite/model/navigation/inner/inner_navigation.dart';
import 'package:vhcsite/model/navigation/navigation_bloc.dart';

HandleNavigation _defaultNav = (b) {
  return null;
};

HandleNavigation _aboutNav = (b) {
  if (b == 'changelog') {
    return const ['changelog'];
  }

  return null;
};

Map<String, InnerNavigation> createInnerNavigationMap() {
  final map = <String, InnerNavigation>{};

  for (final a in POSSIBLE_NAVIGATIONS) {
    switch (a) {
      case "about":
        map[a] = InnerNavigation(_aboutNav);
        break;
      default:
        map[a] = InnerNavigation(_defaultNav);
    }
  }

  return map;
}
