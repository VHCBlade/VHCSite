import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_essay/event_essay.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhcsite/bloc/blog.dart';
import 'package:vhcsite/ui/page/refresh.dart';
import 'package:vhcsite/ui/screens/blog/category.dart';
import 'package:vhcsite/ui/screens/blog/individual_blog.dart';
import 'package:vhcsite/ui/screens/blog/selection/category.dart';
import 'package:vhcsite/ui/screens/blog/selection/search.dart';
import 'package:vhcsite/ui/screens/blog/selection/sort.dart';
import 'package:vhcsite_models/vhcsite_models.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = context.watchBloc<MainNavigationBloc<String>>();

    if (navigation.deepNavigationMap['blog']?.leaf.level == 1) {
      final bloc = context.watchBloc<BlogBloc>();
      final manifest =
          bloc.blogMap[navigation.fullNavigationOnMainNavigation('blog')];

      if (manifest == null) {
        return Container();
      }

      return IndividualBlogScreen(manifest: manifest);
    }
    return const BlogSelectionScreen();
  }
}

class BlogSelectionScreen extends StatelessWidget {
  const BlogSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watchBloc<BlogBloc>();
    return WebRefresh(
      child: EssayScroll(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: double.infinity),
            Text(
              'Blogs',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const CategoryPickerWidget(),
            const BlogSearchWidget(),
            const SizedBox(height: 10),
            const BlogSortWidget(),
            const SizedBox(height: 10),
            ...bloc.sortedSearchList.list.map((e) {
              final manifest = bloc.blogMap[e]!;

              if (!bloc.inCategory(manifest)) {
                return const SizedBox();
              }

              return BlogSelection(manifest: manifest);
            }),
          ],
        ),
      ),
    );
  }
}

final uploadFormat = DateFormat.yMMMd();

class BlogSelection extends StatelessWidget {
  const BlogSelection({super.key, required this.manifest});
  final BlogManifest manifest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        child: TextButton(
          onPressed: () => context.fireEvent(
            NavigationEvent.deepLinkNavigation.event,
            manifest.path,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  manifest.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5),
                Row(children: [
                  Text(
                    'Released On: ${uploadFormat.format(manifest.uploadDate)}',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.left,
                  ),
                  const Expanded(child: SizedBox()),
                  CategoryWidget(convertedPath: manifest.convertedPath),
                ]),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
