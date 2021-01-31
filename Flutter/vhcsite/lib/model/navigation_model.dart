import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

const _POSSIBLE_NAVIGATIONS = {"home", "youtube", "flutter"};

class NavigationModel with Model {
  final EventChannel eventChannel;
  String navigationPath = "home";

  NavigationModel({EventChannel parentChannel})
      : eventChannel = EventChannel(parentChannel) {
    eventChannel.listenForEvent("button", (payload) {
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
    modelUpdated();
  }
}
