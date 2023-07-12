import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_essay/event_essay.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhcsite/bloc/blog.dart';
import 'package:vhcsite/model/blog.dart';
import 'package:vhcsite/ui/screens/blog/category.dart';
import 'package:vhcsite/ui/screens/blog/individual_blog.dart';

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
    return EssayScroll(
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
          Text(
            'Welcome to my blog! Here you can find all of my current blogs in reverse chronological order.',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          ...bloc.blogList.map((e) => BlogSelection(manifest: bloc.blogMap[e]!))
        ],
      ),
    );
  }
}

final _format = DateFormat.yMMMd();

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
                    'Released On: ${_format.format(manifest.uploadDate)}',
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
