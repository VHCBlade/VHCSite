import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/model/blog.dart';

class BlogHeader extends StatelessWidget {
  const BlogHeader({super.key, required this.manifest});
  final BlogManifest manifest;

  @override
  Widget build(BuildContext context) {
    print(manifest.next);
    return Row(children: [
      ElevatedButton(
        onPressed: manifest.previous == null
            ? null
            : () => context.fireEvent(
                NavigationEvent.deepLinkNavigation.event, manifest.previous!),
        child: const Text('Previous'),
      ),
      const Expanded(child: SizedBox()),
      ElevatedButton(
        onPressed: () =>
            context.fireEvent(NavigationEvent.deepLinkNavigation.event, 'blog'),
        child: const Text('Blog List'),
      ),
      const Expanded(child: SizedBox()),
      ElevatedButton(
        onPressed: manifest.next == null
            ? null
            : () => context.fireEvent(
                NavigationEvent.deepLinkNavigation.event, manifest.next!),
        child: const Text('Next'),
      ),
    ]);
  }
}
