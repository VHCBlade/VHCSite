import 'package:event_essay/event_essay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhcsite/events/events.dart';
import 'package:event_bloc/event_bloc.dart';

class UrlRepository extends Repository {
  /// Generates the listener map that this [Repository] will add to the
  @override
  List<BlocEventListener> generateListeners(BlocEventChannel eventChannel) => [
        eventChannel.addEventListener<String>(
            EssayEvent.url.event, (_, val) => _launch(val)),
        eventChannel.addEventListener<String>(VHCSiteEvent.button.event,
            (_, val) {
          if (val == 'youtube') {
            _launch('https://www.youtube.com/channel/UCZ-JaDp28rir6URCI0Gws7Q');
          }
        }),
      ];

  void _launch(String target) {
    launchUrl(Uri.parse((target)));
  }
}
