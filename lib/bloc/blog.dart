import 'dart:convert';

import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:search_me_up/search_me_up.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/blog.dart';

final _dateFormat = DateFormat.yMMMMd();

class BlogBloc extends Bloc {
  BlogBloc({required super.parentChannel}) {
    eventChannel
      ..addEventListener(
        VHCSiteEvent.loadBlog.event,
        (event, value) => initialize(),
      )
      ..addEventListener<String?>(
        VHCSiteEvent.pickBlogCategory.event,
        (event, value) => updateBlocOnChange(
            change: () => category = value, tracker: () => [category]),
      )
      ..addEventListener<String?>(
        VHCSiteEvent.changeBlogSearchTerm.event,
        (event, value) {
          if (value == searchTerm) {
            return;
          }
          searchTerm = value;
          generateSearchList();

          updateBloc();
        },
      );
  }
  bool initialized = false;
  bool initializing = false;

  String? category;
  String? searchTerm;

  String? get sanitizedSearchTerm {
    if (searchTerm == null) {
      return searchTerm;
    }

    return searchTerm!.trim();
  }

  bool inCategory(BlogManifest manifest) {
    return category == null || manifest.category == category;
  }

  final blogMap = <String, BlogManifest>{};

  final sortedSearchList = SortedSearchList<BlogManifest, String>(
    comparator: (a, b) => b.uploadDate.compareTo(a.uploadDate),
    converter: (a) => a.path,
  );

  void generateSearchList() {
    sortedSearchList.generateSearchList(
      searchTerm: sanitizedSearchTerm,
      values: blogMap.values,
      searchMeUp: SearchMeUp(
        DefaultSearchMeUpDelegate(
          converters: [
            (manifest) => [
                  manifest.name,
                  _dateFormat.format(manifest.uploadDate),
                  manifest.category,
                ]
          ],
        ),
      ),
    );
  }

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
      }
      generateSearchList();
      initialized = true;
    } finally {
      initializing = false;
      updateBloc();
    }
  }
}
