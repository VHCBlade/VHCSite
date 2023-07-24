import 'dart:async';

import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/bloc/blog.dart';
import 'package:vhcsite/events/events.dart';

class BlogSearchWidget extends StatefulWidget {
  const BlogSearchWidget({super.key});

  @override
  State<BlogSearchWidget> createState() => _BlogSearchWidgetState();
}

class _BlogSearchWidgetState extends State<BlogSearchWidget> {
  late final controller = TextEditingController();
  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    final bloc = context.readBloc<BlogBloc>();
    controller.text = bloc.searchTerm ?? '';
    subscription = bloc.clearStream
        .listen((event) => setState(() => controller.text = ''));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Search Term'),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => context.fireEvent(
                VHCSiteEvent.changeBlogSearchTerm.event, value),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => context.fireEvent(
              VHCSiteEvent.changeBlogSearchTerm.event, controller.text),
          child: const Text('Search'),
        ),
      ],
    );
  }
}
