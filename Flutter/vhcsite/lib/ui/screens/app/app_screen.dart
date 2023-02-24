import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vhcblade_theme/vhcblade_widget.dart';
import 'package:vhcsite/ui/page/essay_page.dart';

const apps = ["reviewer", "weight"];

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final ratio = pow(query.devicePixelRatio, 1 / 3);
    final width = query.size.width;
    final adjustedWidth = width / ratio;

    final items = max(adjustedWidth ~/ 300, 1);
    return EssayScroll(
      child: FlexibleGrid(
          itemCount: apps.length,
          builder: (index, _) => Card(
                child: EssayScreen(
                  path: ["apps", apps[index]],
                ),
              ),
          itemsPerRow: items),
    );
  }
}
