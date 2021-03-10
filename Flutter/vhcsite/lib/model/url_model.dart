import 'package:url_launcher/url_launcher.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model.dart';

class UrlModel with Model {
  final ProviderEventChannel eventChannel;

  UrlModel({ProviderEventChannel? parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener(URL_EVENT, (payload) {
      _launch(payload);
      return false;
    });
    // Redirect to YouTube Channel
    eventChannel.addEventListener(BUTTON_EVENT, (payload) {
      if (payload == 'youtube') {
        _launch('https://www.youtube.com/channel/UCZ-JaDp28rir6URCI0Gws7Q');
      }
      return false;
    });
  }

  // TODO Transfer this to a repo
  void _launch(String target) {
    launch(target);
  }
}
