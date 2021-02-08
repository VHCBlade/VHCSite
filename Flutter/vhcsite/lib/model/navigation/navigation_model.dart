import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

const POSSIBLE_NAVIGATIONS = <String>{"home", "flutter", "about"};

class NavigationModel with Model {
  final ProviderEventChannel eventChannel;
  String navigationPath = "home";

  NavigationModel({ProviderEventChannel? parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener(BUTTON_EVENT, (payload) {
      navigate(payload);
      return false;
    });
  }

  void navigate(String navigate) {
    if (!_POSSIBLE_NAVIGATIONS.contains(navigate)) {
      return;
    }

    if (navigationPath == navigate) {
      return;
    }

    navigationPath = navigate;
    updateModel();
  }
}
