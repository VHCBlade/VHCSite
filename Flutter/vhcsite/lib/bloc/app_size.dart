import 'dart:math';

import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:vhcsite/events/events.dart';

const DEVICE_THRESHHOLD = 600;

// 1 refers to normal, 0 means smallest

class AppSizeBloc extends Bloc {
  int showState = 1;

  AppSizeBloc({super.parentChannel}) {
    eventChannel.addEventListener<MediaQueryData>(
        DataEvent.mediaQuery.event,
        (_, val) => updateBlocOnChange(
            tracker: () => [showState],
            change: () => showState = getStateFromMediaQuery(val)));
  }

  int getStateFromMediaQuery(MediaQueryData query) {
    final ratio = pow(query.devicePixelRatio, 1 / 3);
    final width = query.size.width;
    final adjustedWidth = width / ratio;
    print(adjustedWidth);

    return adjustedWidth > DEVICE_THRESHHOLD ? 1 : 0;
  }
}
