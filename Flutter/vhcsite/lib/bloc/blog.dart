import 'package:event_bloc/event_bloc.dart';
import 'package:vhcsite/model/blog.dart';

class BlogBloc extends Bloc {
  var blogMap = <String, Map<String, BlogManifest>>{};

  BlogBloc({required super.parentChannel});
}
