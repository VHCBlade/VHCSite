// UI Events
import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/bloc/blog.dart';

enum VHCSiteEvent<T> {
  button<String>(),
  setTextScale<double>(),

  loadBlog<void>(),
  pickBlogCategory<String?>(),
  changeBlogSearchTerm<String?>(),
  pickBlogSortOrder<BlogSortOrder>(),
  clearCategoryFilters<void>(),

  loadBlogViews<String>(),
  recordBlogView<String>(),
  ;

  BlocEventType<T> get event => BlocEventType.fromObject(this);
}

enum DataEvent<T> {
  mediaQuery<MediaQueryData>(),
  ;

  BlocEventType<T> get event => BlocEventType.fromObject(this);
}
