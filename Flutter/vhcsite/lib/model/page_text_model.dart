import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:event_bloc/event_bloc.dart';

class PageTextBloc with Bloc {
  final BlocEventChannel eventChannel;
  final TextRepository repository;
  final List<String> path;

  bool loaded = false;
  bool _loading = false;
  final values = <String, String>{};

  String safeGetValue(String value) => values[value] ?? '';
  String get stringPath => path.reduce((a, b) => "$a/$b");

  PageTextBloc(
      {BlocEventChannel? parentChannel,
      required this.repository,
      required this.path})
      : eventChannel = BlocEventChannel(parentChannel) {
    eventChannel.addEventListener(
        TEXT_FILES_EVENT, (dynamic) => _retrieveTextFiles());
  }

  bool _retrieveTextFiles() {
    if (!_loading) {
      _loading = true;
    }

    repository.loadTextRepository(path).then((a) {
      values.addAll(a);
      loaded = true;
      updateBloc();
    });

    return true;
  }
}
