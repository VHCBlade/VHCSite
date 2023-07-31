import 'package:event_api/event_api.dart';
import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_db/event_db.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite_models/vhcsite_models.dart';

class BlogViewsBloc extends Bloc {
  BlogViewsBloc({
    required super.parentChannel,
    required this.api,
    required this.database,
  }) {
    eventChannel
      ..addEventListener<String>(
          VHCSiteEvent.loadBlogViews.event, (event, value) => loadViews(value))
      ..addEventListener<String>(VHCSiteEvent.recordBlogView.event,
          (event, value) => recordView(value));
  }

  final APIRepository api;
  final DatabaseRepository database;

  late final blogViewsMap = <String, BlogViews>{};
  late final viewRecordedMap = GenericModelMap(
    repository: () => database,
    supplier: BlogViews.new,
    defaultDatabaseName: 'blogViews',
  );

  int? views(String path) => blogViewsMap[path]?.viewCount;

  void recordView(String path) async {
    final blogViewsId = BlogViews().prefixTypeForId(path);
    if (viewRecordedMap.map.containsKey(blogViewsId)) {
      return;
    }

    await viewRecordedMap.loadModelIds([blogViewsId]);
    if (viewRecordedMap.map.containsKey(blogViewsId)) {
      return;
    }

    final response = await api.request(
        'POST', 'blog/${path.replaceAll('/', '-')}/views', (request) => null);

    if (response.statusCode != 200) {
      return;
    }

    await viewRecordedMap.addModel(BlogViews()..path = path);
  }

  void loadViews(String path) async {
    final response = await api.request(
        'GET', 'blog/${path.replaceAll('/', '-')}/views', (request) => null);

    if (response.statusCode != 200) {
      return;
    }

    blogViewsMap[path] = await response.bodyAsModel(BlogViews.new);
    updateBloc();
  }
}
