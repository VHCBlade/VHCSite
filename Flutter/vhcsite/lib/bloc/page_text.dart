import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:event_bloc/event_bloc.dart';

class PageTextBloc extends Bloc {
  final TextRepository repository;
  final List<String> path;

  bool loaded = false;
  bool _loading = false;
  String value = "";

  String get stringPath => path.reduce((a, b) => "$a/$b");

  PageTextBloc(
      {super.parentChannel, required this.repository, required this.path}) {
    eventChannel.addEventListener(
        DataEvent.textFiles.event, (_, val) => _retrieveTextFiles());
  }

  void _retrieveTextFiles() async {
    if (_loading) {
      return;
    }

    value = await repository.loadText(path);

    _loading = false;
    loaded = true;
    updateBloc();
    return;
  }
}
