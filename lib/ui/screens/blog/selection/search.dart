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

  @override
  void initState() {
    super.initState();
    controller.text = context.readBloc<BlogBloc>().searchTerm ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Search Term'),
        ),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        onPressed: () => context.fireEvent(
            VHCSiteEvent.changeBlogSearchTerm.event, controller.text),
        child: const Text('Search'),
      ),
    ]);
  }
}
