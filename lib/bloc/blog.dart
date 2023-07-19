import 'dart:convert';

import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/services.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/blog.dart';

class BlogBloc extends Bloc {
  BlogBloc({required super.parentChannel}) {
    eventChannel.addEventListener(
      UIEvent.loadBlog.event,
      (event, value) => initialize(),
    );
    eventChannel.addEventListener<String?>(
      UIEvent.pickBlogCategory.event,
      (event, value) => updateBlocOnChange(
          change: () => category = value, tracker: () => [category]),
    );
  }
  bool initialized = false;
  bool initializing = false;

  String? category;

  bool inCategory(BlogManifest manifest) {
    return category == null || manifest.category == category;
  }

  final blogMap = <String, BlogManifest>{};
  final blogList = <String>[];

  void initialize() async {
    if (initialized || initializing) {
      return;
    }
    initializing = true;
    try {
      final bundle = await rootBundle.loadString('assets/text/manifest.json');
      final decoded = (json.decode(bundle) as List<dynamic>)
          .map((e) => BlogManifest()..loadFromMap(e))
          .toList();
      for (int i = 0; i < decoded.length; i++) {
        blogMap[decoded[i].path] = decoded[i];
        if (i > 0) {
          decoded[i].next = decoded[i - 1].path;
          decoded[i - 1].previous = decoded[i].path;
        }
        blogList.add(decoded[i].path);
      }
      initialized = true;
    } finally {
      initializing = false;
      updateBloc();
    }
  }
}
