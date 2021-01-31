import 'package:url_launcher/url_launcher.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model.dart';

class UrlModel with Model {
  final EventChannel eventChannel;

  UrlModel({EventChannel parentChannel})
      : eventChannel = EventChannel(parentChannel) {
    eventChannel.addEventListener("url", (payload) {
      launch(payload);
      return false;
    });
    // Redirect to YouTube Channel
    eventChannel.addEventListener("button", (payload) {
      if (payload == 'youtube') {
        launch('https://www.youtube.com/channel/UCZ-JaDp28rir6URCI0Gws7Q');
      }
      return false;
    });
  }
}
