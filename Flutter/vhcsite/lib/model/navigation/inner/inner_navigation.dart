typedef List<String>? HandleNavigation(String val);

class InnerNavigation {
  final HandleNavigation navigationHandler;

  InnerNavigation(this.navigationHandler);

  List<String> navigationPath = [];

  /// Sets the current Navigation Path to the given [path]
  ///
  /// If [path] is invalid, will return false
  bool setNavigation(String path) {
    final navPath = navigationHandler(path);

    if (navPath == null) {
      return false;
    }

    navigationPath = navPath;

    return true;
  }

  /// Takes the current [navigationPath] and attempts to navigate one level
  /// deeper to [path].
  ///
  /// If [path] is invalid, will return false
  bool navigateToPath(String path) {
    return setNavigation(
        navigationPath.reduce((value, element) => '$value/$element'));
  }

  /// Pops the navigation one level, returns false if [navigationPath] is
  /// already empty.
  bool popNavigation() {
    if (navigationPath.isEmpty) {
      return false;
    }

    navigationPath = navigationPath.sublist(0, navigationPath.length - 1);

    return true;
  }
}
