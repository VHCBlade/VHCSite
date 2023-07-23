import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

class WebRefresh extends StatelessWidget {
  const WebRefresh({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }

    return RefreshIndicator(
        onRefresh: () async => window.location.reload(), child: child);
  }
}
