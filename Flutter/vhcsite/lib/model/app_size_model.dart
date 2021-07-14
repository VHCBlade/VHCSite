import 'dart:math';

import 'package:event_bloc/event_bloc.dart';
import 'package:vhcsite/events/events.dart';

const DEVICE_THRESHHOLD = 400;

// 1 refers to normal, 0 means smallest

class AppSizeBloc with Bloc {
  final BlocEventChannel eventChannel;

  int showState = 1;

  AppSizeBloc({BlocEventChannel? parentChannel})
      : eventChannel = BlocEventChannel(parentChannel) {
    eventChannel.addEventListener(MEDIA_QUERY_EVENT, (value) {
      // MediaQueryData
      updateBlocOnChange(
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
