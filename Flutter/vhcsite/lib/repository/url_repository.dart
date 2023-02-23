import 'package:url_launcher/url_launcher.dart';
import 'package:vhcsite/events/events.dart';
import 'package:event_bloc/event_bloc.dart';

class UrlRepository extends Repository {
  /// Generates the listener map that this [Repository] will add to the
  @override
  List<BlocEventListener> generateListeners(BlocEventChannel eventChannel) => [
        eventChannel.addEventListener<String>(
            UIEvent.url.event, (_, val) => _launch(val)),
        eventChannel.addEventListener<String>(UIEvent.button.event, (_, val) {
          if (val == 'youtube') {
            _launch('https://www.youtube.com/channel/UCZ-JaDp28rir6URCI0Gws7Q');
          }
        }),
      ];

  void _launch(String target) {
    launch(target);
  }
}
