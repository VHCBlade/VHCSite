import 'package:collection/equality.dart';

typedef List<String> HandleNavigation(String val);

final equality = const ListEquality().equals;

class InnerNavigation {
  final HandleNavigation navigationHandler;

  InnerNavigation(this.navigationHandler);

  List<String> navigationPath = [];

  bool setNavigation(String path) {
    final navPath = navigationPath;
    navigationPath = navigationHandler(path);
    return !equality(navigationPath, navPath);
  }
}
