import 'package:event_essay/event_essay.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/ui/page/refresh.dart';
import 'package:vhcsite/ui/screens/blog/header.dart';
import 'package:vhcsite_models/vhcsite_models.dart';

class IndividualBlogScreen extends StatelessWidget {
  const IndividualBlogScreen({super.key, required this.manifest});
  final BlogManifest manifest;

  @override
  Widget build(BuildContext context) {
    return WebRefresh(
      child: EssayScreen(
        leading: [
          BlogHeader(manifest: manifest),
          Text(manifest.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).primaryColor)),
        ],
        trailing: [
          Text('VHCBlade',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).primaryColor)),
          BlogHeader(manifest: manifest),
        ],
        path: manifest.convertedPath,
      ),
    );
  }
}
