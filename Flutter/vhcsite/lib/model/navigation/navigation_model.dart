import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/navigation/inner/navigations.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

const POSSIBLE_NAVIGATIONS = <String>{"home", "dev", "about", "error"};

class NavigationModel with Model {
  final ProviderEventChannel eventChannel;
  String navigationPath = 'home';
  final _storedNavigations = createInnerNavigationMap();

  List<String> get innerNavigation =>
      _storedNavigations[navigationPath]!.navigationPath;

  NavigationModel({ProviderEventChannel? parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener(BUTTON_EVENT, (payload) {
      navigate(payload, false);
      return false;
    });
    eventChannel.addEventListener(MAIN_NAVIGATION_EVENT, (payload) {
      // treat empty as home
      navigate(payload == '' ? 'home' : payload, true);
      return false;
    });
  }

  void navigate(String navigate, bool errorOnFail) {
    updateModelOnChange(
      tracker: () => [navigationPath, innerNavigation],
      change: () {
        final firstSlash = navigate.indexOf('/');
        final mainNav =
            firstSlash < 0 ? navigate : navigate.substring(0, firstSlash);

        // Check if the navigation is actually valid.
        if (!POSSIBLE_NAVIGATIONS.contains(mainNav)) {
          // Check if the navigation path should be changed to error.
          if (!errorOnFail) {
            return;
          }

          navigationPath = 'error';
          return;
        }
        navigationPath = mainNav;

        if (firstSlash < 0) {
          return;
        }

        final innerNavigation = _storedNavigations[navigationPath]!;
        final failedNavigation =
            !innerNavigation.setNavigation(navigate.substring(firstSlash + 1));
        if (failedNavigation) {
          navigationPath = 'error';
        }
      },
    );
  }
}
