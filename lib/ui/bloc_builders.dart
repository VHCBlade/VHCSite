import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:vhcsite/bloc/app_size.dart';
import 'package:vhcsite/bloc/blog.dart';
import 'package:vhcsite/bloc/navigation/navigation_bloc.dart';

final blocBuilders = [
  BlocBuilder<AppSizeBloc>(
      (reader, parentChannel) => AppSizeBloc(parentChannel: parentChannel)),
  BlocBuilder<MainNavigationBloc<String>>(
      (reader, parentChannel) => generateNavigationBloc(parentChannel)),
  BlocBuilder<BlogBloc>(
      (reader, parentChannel) => BlogBloc(parentChannel: parentChannel)),
];
