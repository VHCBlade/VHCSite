import 'dart:math';

import 'package:event_essay/event_essay.dart';
import 'package:flutter/material.dart';
import 'package:vhcblade_theme/vhcblade_widget.dart';

const apps = ["reviewer", "weight"];
const otherApps = ["pearls"];

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final ratio = pow(query.devicePixelRatio, 1 / 3);
    final width = query.size.width;
    final adjustedWidth = width / ratio;

    final items = min(max(adjustedWidth ~/ 300, 1), 4);
    return EssayScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "My Apps",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              )),
          FlexibleGrid(
            shrinkWrap: true,
            itemCount: apps.length,
            rowAlignment: CrossAxisAlignment.start,
            builder: (index, _) => Card(
              child: EssayScreen(
                path: ["apps", apps[index]],
              ),
            ),
            itemsPerRow: items,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Apps Made for Others",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
          ),
          FlexibleGrid(
            shrinkWrap: true,
            itemCount: otherApps.length,
            rowAlignment: CrossAxisAlignment.start,
            builder: (index, _) => Card(
              child: EssayScreen(
                path: ["apps", otherApps[index]],
              ),
            ),
            itemsPerRow: items,
          ),
        ],
      ),
    );
  }
}
