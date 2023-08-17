import 'package:flutter/material.dart';
import 'package:vhcsite/ui/watcher/text_scale.dart';
import 'package:vhcsite/ui/watcher/version.dart';

class WatcherLayer extends StatelessWidget {
  const WatcherLayer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextScaleWatcher(
      child: VersionWatcher(
        child: child,
      ),
    );
  }
}
