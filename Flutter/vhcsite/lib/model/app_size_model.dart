import 'dart:math';

import 'package:vhcsite/state/event_channel.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/events/events.dart';

const DEVICE_THRESHHOLD = 400;

// 1 refers to normal, 0 means smallest

class AppSizeModel with Model {
  final ProviderEventChannel eventChannel;

  int showState = 1;

  AppSizeModel({ProviderEventChannel? parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener(MEDIA_QUERY_EVENT, (value) {
      // MediaQueryData
      updateModelOnChange(
          tracker: () => [showState],
          change: () => showState = getStateFromMediaQuery(value));

      return false;
    });
  }

  int getStateFromMediaQuery(dynamic query) {
    final ratio = pow(query.devicePixelRatio, 1 / 3);
    final width = query.size.width;
    final adjustedWidth = width / ratio;

    return adjustedWidth > DEVICE_THRESHHOLD ? 1 : 0;
  }
}
