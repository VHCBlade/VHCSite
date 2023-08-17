import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:vhcsite/bloc/app_size.dart';
import 'package:vhcsite/bloc/blog.dart';
import 'package:vhcsite/bloc/blog_views.dart';
import 'package:vhcsite/bloc/navigation/navigation_bloc.dart';
import 'package:vhcsite/bloc/version.dart';

final blocBuilders = [
  BlocBuilder<AppSizeBloc>(
      (reader, parentChannel) => AppSizeBloc(parentChannel: parentChannel)),
  BlocBuilder<MainNavigationBloc<String>>(
      (reader, parentChannel) => generateNavigationBloc(parentChannel)),
  BlocBuilder<BlogBloc>(
      (reader, parentChannel) => BlogBloc(parentChannel: parentChannel)),
  BlocBuilder<BlogViewsBloc>(
    (reader, parentChannel) => BlogViewsBloc(
      parentChannel: parentChannel,
      api: reader.read(),
      database: reader.read(),
    ),
  ),
  BlocBuilder<VersionBloc>(
    (reader, parentChannel) => VersionBloc(
      parentChannel: parentChannel,
      api: reader.read(),
    ),
  ),
];
