import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:event_modals/event_modals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';
import 'package:vhcsite/events/events.dart';

class VersionWatcher extends StatefulWidget {
  const VersionWatcher({super.key, required this.child});
  final Widget child;

  @override
  State<VersionWatcher> createState() => _VersionWatcherState();
}

class _VersionWatcherState extends State<VersionWatcher> {
  late final BlocEventListener<dynamic> subscription;

  @override
  void initState() {
    super.initState();
    subscription = context.eventChannel.eventBus.addEventListener(
      VHCSiteEvent.versionOutdated.event,
      (event, value) {
        if (!kIsWeb) {
          return;
        }
        showEventDialog<bool>(
          context: context,
          builder: (_) => const WebVersionModal(),
          onResponse: (channel, response) {
            if (!response) {
              return;
            }
            window.location.reload();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class WebVersionModal extends StatelessWidget {
  const WebVersionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Version'),
      content: const Text(
        'There is a new version available. Would you like to refresh to get the latest version?',
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No Thanks'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Refresh'),
        ),
      ],
    );
  }
}
