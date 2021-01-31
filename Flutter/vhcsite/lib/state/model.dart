import 'package:vhcsite/state/event_channel.dart';

abstract class Model {
  void Function() modelUpdated = () {};
  EventChannel get eventChannel;
}
