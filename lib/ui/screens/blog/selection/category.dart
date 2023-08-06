import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/bloc/blog.dart';
import 'package:vhcsite/events/events.dart';

class CategoryPickerWidget extends StatelessWidget {
  const CategoryPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final category =
        context.selectBloc<BlogBloc, String?>((blog) => blog.category);
    return Row(
      children: [
        const Text('Blog Category'),
        const Expanded(child: SizedBox()),
        DropdownButton<String?>(
          items: const [
            DropdownMenuItem(value: 'flutter', child: Text('Flutter')),
            DropdownMenuItem(value: 'games', child: Text('Games')),
            DropdownMenuItem(value: 'life', child: Text('Life')),
            DropdownMenuItem(value: 'poems', child: Text('Poems')),
            DropdownMenuItem(child: Text('All')),
          ],
          value: category,
          onChanged: (value) =>
              context.fireEvent(VHCSiteEvent.pickBlogCategory.event, value),
        ),
      ],
    );
  }
}
