import 'package:event_api/event_api.dart';
import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/services.dart';
import 'package:vhcsite/events/events.dart';

Future<String> _loadFromRootBundle() => rootBundle.loadString('assets/VERSION');

class VersionBloc extends Bloc {
  VersionBloc({
    required super.parentChannel,
    required this.api,
    this.getVersion = _loadFromRootBundle,
  }) {
    eventChannel
      ..addEventListener(
          VHCSiteEvent.loadVersion.event, (event, value) => loadVersion())
      ..addEventListener(VHCSiteEvent.loadApiVersion.event,
          (event, value) => loadApiVersion());
  }

  final Future<String> Function() getVersion;

  final APIRepository api;

  String? apiVersion;
  String? version;

  void loadVersion() async {
    version = await getVersion();
    versionCheck();
    updateBloc();
  }

  void loadApiVersion() async {
    final response = await api.request('GET', 'version', (_) => null);
    if (response.statusCode != 200) {
      print(response.statusCode);
      return;
    }
    apiVersion = await response.body;

    versionCheck();
    updateBloc();
  }

  void versionCheck() {
    if (apiVersion == null || version == null || version == apiVersion) {
      return;
    }

    eventChannel.eventBus.fireEvent(VHCSiteEvent.versionOutdated.event, null);
  }
}
