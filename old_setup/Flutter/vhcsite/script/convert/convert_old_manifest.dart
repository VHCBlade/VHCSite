import 'dart:convert';
import 'dart:io';

import 'package:vhcsite/model/blog.dart';

// This script is commented out so that it won't accidentally be ran.
void main() {
  final file = File('assets/text/manifest.txt');
  final fileData = file.readAsStringSync().split('\n');
  final blogManifests = <BlogManifest>[];
  for (final data in fileData) {
    final splitData = data.split('/');
    final manifest = BlogManifest()
      ..idSuffix = '${blogManifests.length}'
      ..name = splitData[1]
      ..path = splitData[0].replaceAll('-', '/')
      ..uploadDate = DateTime(
        int.parse(splitData[2].substring(0, 4)),
        int.parse(splitData[2].substring(5, 7)),
        int.parse(splitData[2].substring(8)),
      );
    blogManifests.insert(0, manifest);
  }

  final outputFile = File('assets/text/manifest.json');

  outputFile.writeAsStringSync(
      json.encode(blogManifests.map((e) => e.toMap()).toList()));

  // ignore: avoid_print
  print('Successfully Converted!');
}
