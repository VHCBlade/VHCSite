import 'package:vhcsite/state/event_channel.dart';

abstract class Model {
  /// Add functions to this to be ran when the model is updated.
  List<void Function()> modelUpdated = [];

  /// Events that the UI fire to affect this model are received through here.
  ProviderEventChannel get eventChannel;

  void updateModel() => modelUpdated.forEach((element) => element());

  void dispose() {}
}
