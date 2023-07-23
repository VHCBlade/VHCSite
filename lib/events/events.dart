// UI Events
import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

enum UIEvent<T> {
  button<String>(),
  setTextScale<double>(),
  loadBlog<void>(),
  pickBlogCategory<String?>(),
  ;

  BlocEventType<T> get event => BlocEventType.fromObject(this);
}

enum DataEvent<T> {
  mediaQuery<MediaQueryData>(),
  ;

  BlocEventType<T> get event => BlocEventType.fromObject(this);
}
