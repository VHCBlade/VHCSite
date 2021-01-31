import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

const _POSSIBLE_NAVIGATIONS = {"home", "flutter"};

class NavigationModel with Model {
  final ProviderEventChannel eventChannel;
  String navigationPath = "home";

  NavigationModel({ProviderEventChannel parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener("button", (payload) {
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
