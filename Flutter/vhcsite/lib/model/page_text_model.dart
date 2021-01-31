import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model.dart';

class PageTextModel with Model {
  final ProviderEventChannel eventChannel;
  final TextRepository repository;
  final List<String> path;

  bool loaded = false;
  bool _loading = false;
  final values = <String, String>{};

  String safeGetValue(String value) => values[value] ?? '';

  PageTextModel(
      {ProviderEventChannel parentChannel, this.repository, this.path})
      : eventChannel = ProviderEventChannel(parentChannel) {
    assert(repository != null);
    eventChannel.addEventListener(
        'retrieve_text_files', (dynamic) => _retrieveTextFiles());
  }

  bool _retrieveTextFiles() {
    if (!_loading) {
      _loading = true;
    }

    repository
        .loadTextRepository(path)
        .then((a) => values.addAll(a))
        .whenComplete(() {
      loaded = true;
      updateModel();
    });

    return true;
  }
}