import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/events/events.dart';

const DEVICE_THRESHHOLD = 700;

class AppSizeModel with Model {
  final ProviderEventChannel eventChannel;

  int showState = 1;

  AppSizeModel({ProviderEventChannel? parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener(MEDIA_QUERY, (value) {
      // MediaQueryData
      final ratio = value.devicePixelRatio;
      final width = value.size.width;

      final newState = width / ratio > 700;
      print(width);
      print(width / ratio);

      return false;
    });
  }
}
