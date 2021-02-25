import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/navigation/inner/inner_navigation.dart';
import 'package:vhcsite/model/navigation/inner/navigations.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

const POSSIBLE_NAVIGATIONS = <String>{"home", "dev", "about", "error"};

class NavigationModel with Model {
  final ProviderEventChannel eventChannel;
  String navigationPath = 'home';
  final _storedNavigations = createInnerNavigationMap();

  InnerNavigation get innerNavigation => _storedNavigations[navigationPath]!;
  List<String> get subNavigation => innerNavigation.navigationPath;
  String get fullNavigation =>
      ([navigationPath]..addAll(subNavigation)).reduce((a, b) => "$a/$b");

  List<String> getSpecificSubNavigation(String specificNavigationPath) {
    final specificPath = _storedNavigations[specificNavigationPath];

    if (specificPath == null) {
      return const [];
    }

    return specificPath.navigationPath;
  }

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
    eventChannel.addEventListener(SUB_NAVIGATION_EVENT, (payload) {
      subNavigate(payload, true);
      return false;
    });
  }

  /// Navigates to the absolute navigation given by [navigate]
  ///
  /// If [errorOnFail] is true, if [navigate] is invalid, will navigate to
  /// the error screen.
  void navigate(String navigate, bool errorOnFail) {
    updateModelOnChange(
      tracker: () => [navigationPath, subNavigation],
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

        // Sub Navigate
        final failedNavigation =
            !innerNavigation.setNavigation(navigate.substring(firstSlash + 1));
        if (failedNavigation) {
          navigationPath = 'error';
        }
      },
    );
  }

  /// Changes the SubNavigation of this navigation model.
  ///
  /// [payload] will be appended to the sub navigation path unless if it's
  /// special.
  ///
  /// If [payload] == 'back' then the navigation will pop.
  void subNavigate(String payload, bool errorOnFail) {
    updateModelOnChange(
      tracker: () => [navigationPath, subNavigation],
      change: () {
        // Attempt to Navigate further.
        final list = <String>[];
        list.addAll(subNavigation);
        list.add(payload);

        final newNavigation =
            list.reduce((value, element) => "$value/$element");

        final failedNavigation = !innerNavigation.setNavigation(newNavigation);
        if (errorOnFail && failedNavigation) {
          navigationPath = 'error';
        }
      },
    );
  }
}
