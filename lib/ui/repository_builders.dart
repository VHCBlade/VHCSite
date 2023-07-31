import 'package:event_api/event_api.dart';
import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_db/event_db.dart';
import 'package:event_hive/event_hive.dart';
import 'package:flutter/foundation.dart';
import 'package:vhcsite/repository/url_repository.dart';
import 'package:vhcsite_models/vhcsite_models.dart';

import 'package:vhcsite/local.dart' as local;
import 'package:vhcsite/site.dart' as site;

final repositoryBuilders = [
  RepositoryBuilder<DatabaseRepository>(
    (reader) => HiveRepository(
      typeAdapters: [
        GenericTypeAdapter(BlogViews.new, (p0) => 1),
      ],
    ),
  ),
  RepositoryBuilder<APIRepository>(
    (reader) => APIRepository(
      database: SpecificDatabase(reader.read<DatabaseRepository>(), 'database'),
      requester: ServerAPIRequester(
        apiServer: kDebugMode ? local.site : site.site,
        website: site.website,
      ),
    ),
  ),
  RepositoryBuilder<UrlRepository>((reader) => UrlRepository()),
];
