// UI Events
import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

enum UIEvent<T> {
  button<String>(),
  url<String>(),
  updateScroll<void>(),
  ;

  BlocEventType<T> get event => BlocEventType.fromObject(this);
}

enum DataEvent<T> {
  textFiles<void>(),
  mediaQuery<MediaQueryData>(),
  ;

  BlocEventType<T> get event => BlocEventType.fromObject(this);
}
