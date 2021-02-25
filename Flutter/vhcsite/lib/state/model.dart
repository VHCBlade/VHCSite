import 'package:collection/collection.dart';
import 'package:vhcsite/state/event_channel.dart';

final Function equality = const DeepCollectionEquality().equals;

abstract class Model {
  /// Add functions to this to be ran when the model is updated.
  List<void Function()> modelUpdated = [];

  /// Events that the UI fire to affect this model are received through here.
  ProviderEventChannel get eventChannel;

  /// Updates the model after calling [change] if the value returned by
  /// [tracker] changes.
  ///
  /// Slightly less efficient than writing the code yourself, but reduces
  /// boilerplate.
  void updateModelOnChange(
      {required void Function() change,
      required List<dynamic> Function() tracker}) {
    final track = tracker();

    change();

    if (!equality(track, tracker())) {
      updateModel();
    }
  }

  void updateModel() => modelUpdated.forEach((element) => element());

  void dispose() {}
}
