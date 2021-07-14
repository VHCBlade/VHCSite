import 'package:url_launcher/url_launcher.dart';
import 'package:vhcsite/events/events.dart';
import 'package:event_bloc/event_bloc.dart';

class UrlRepository extends Repository {
  /// Generates the listener map that this [Repository] will add to the
  Map<String, BlocEventListener> generateListenerMap() => {
        URL_EVENT:
            BlocEventChannel.simpleListener((payload) => _launch(payload)),
        BUTTON_EVENT: ((payload) {
          if (payload == 'youtube') {
            _launch('https://www.youtube.com/channel/UCZ-JaDp28rir6URCI0Gws7Q');
          }
          return false;
        }),
      };

  void _launch(String target) {
    launch(target);
  }
}
