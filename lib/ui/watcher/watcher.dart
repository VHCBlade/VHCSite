import 'package:flutter/material.dart';
import 'package:vhcsite/ui/watcher/text_scale.dart';

class WatcherLayer extends StatelessWidget {
  const WatcherLayer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextScaleWatcher(child: child);
  }
}
