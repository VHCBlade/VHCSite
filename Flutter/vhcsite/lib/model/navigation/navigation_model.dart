import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

const POSSIBLE_NAVIGATIONS = <String>{"home", "dev", "about", "error"};

class NavigationModel with Model {
  final ProviderEventChannel eventChannel;
  String navigationPath = 'home';

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
    if (navigationPath == navigate) {
      return;
    }

    // Check if the navigation is actually valid.
    if (!POSSIBLE_NAVIGATIONS.contains(navigate)) {
      // Check if the navigation path should be changed to error.
      if (!(errorOnFail && navigationPath != 'error')) {
        return;
      }

      navigationPath = 'error';
    } else {
      navigationPath = navigate;
    }

    updateModel();
  }
}
