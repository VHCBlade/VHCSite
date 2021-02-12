import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/navigation/navigation_model.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

class InnerNavigationModel with Model {
  final ProviderEventChannel eventChannel;
  final NavigationModel navigationModel;

  final map = Map.fromIterable(POSSIBLE_NAVIGATIONS,
      key: (val) => val, value: (_) => <String>[]);

  InnerNavigationModel(this.navigationModel,
      {ProviderEventChannel? parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener(BUTTON_EVENT, (payload) {
      navigate(payload);
      return false;
    });
  }

  void navigate(String navigate) {
    updateModel();
  }
}
