import 'package:vhcsite/state/event_channel.dart';

abstract class Model {
  List<void Function()> modelUpdated = [];
  ProviderEventChannel get eventChannel;

  void updateModel() => modelUpdated.forEach((element) => element());

  void dispose() {}
}
