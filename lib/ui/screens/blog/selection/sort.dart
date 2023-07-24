import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/bloc/blog.dart';
import 'package:vhcsite/events/events.dart';

class BlogSortWidget extends StatelessWidget {
  const BlogSortWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sortOrder =
        context.selectBloc<BlogBloc, BlogSortOrder>((blog) => blog.sortOrder);
    return Row(
      children: [
        DropdownButton<BlogSortOrder>(
          items: BlogSortOrder.values
              .map((e) =>
                  DropdownMenuItem(value: e, child: Text('Sort ${e.display}')))
              .toList(),
          value: sortOrder,
          onChanged: (value) => context.fireEvent(
              VHCSiteEvent.pickBlogSortOrder.event,
              value ?? BlogSortOrder.dateDescending),
        ),
        const Expanded(child: SizedBox()),
        ElevatedButton(
          onPressed: () =>
              context.fireEvent(VHCSiteEvent.clearCategoryFilters.event, null),
          child: const Text('Clear Filters'),
        )
      ],
    );
  }
}
