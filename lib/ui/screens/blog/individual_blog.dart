import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_essay/event_essay.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/bloc/blog_views.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/ui/page/refresh.dart';
import 'package:vhcsite/ui/screens/blog/header.dart';
import 'package:vhcsite_models/vhcsite_models.dart';

class IndividualBlogScreen extends StatefulWidget {
  const IndividualBlogScreen({super.key, required this.manifest});
  final BlogManifest manifest;

  @override
  State<IndividualBlogScreen> createState() => _IndividualBlogScreenState();
}

class _IndividualBlogScreenState extends State<IndividualBlogScreen> {
  @override
  void initState() {
    super.initState();
    context.fireEvent(VHCSiteEvent.loadBlogViews.event, widget.manifest.path);
    context.fireEvent(VHCSiteEvent.recordBlogView.event, widget.manifest.path);
  }

  @override
  void didUpdateWidget(IndividualBlogScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    context.fireEvent(VHCSiteEvent.loadBlogViews.event, widget.manifest.path);
    context.fireEvent(VHCSiteEvent.recordBlogView.event, widget.manifest.path);
  }

  @override
  Widget build(BuildContext context) {
    final viewCount = context.selectBloc<BlogViewsBloc, int?>(
        (bloc) => bloc.views(widget.manifest.path));

    return WebRefresh(
      child: EssayScreen(
        leading: [
          BlogHeader(manifest: widget.manifest),
          Text(widget.manifest.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).primaryColor)),
        ],
        trailing: [
          Text('VHCBlade',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).primaryColor)),
          if (viewCount != null)
            Row(children: [
              Text('$viewCount'),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () => context.fireEvent(
                  EssayEvent.url.event,
                  'https://vhcblade.com/assets/assets/text/html/${widget.manifest.convertedPath.join('-')}.html',
                ),
                child: const Text('Raw HTML'),
              )
            ]),
          BlogHeader(manifest: widget.manifest),
        ],
        path: widget.manifest.convertedPath,
      ),
    );
  }
}
