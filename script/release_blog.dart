import 'dart:convert';
import 'dart:io';

import 'package:vhcsite/model/blog.dart';

void main() {
  const directory = 'assets/text/blog';
  final manifestFile = File('assets/text/manifest.json');

  final rawManifest = manifestFile.readAsStringSync();
  final manifest = json.decode(rawManifest) as List<dynamic>;
  final blogMap = <String, BlogManifest>{};

  for (final map in manifest) {
    final blogManifest = BlogManifest()..loadFromMap(map);
    blogMap[blogManifest.path] = blogManifest;
  }

  actOnMarkdownFiles(directory, (markdown) {
    final currentPath = markdown.substring(12, markdown.indexOf('.'));
    if (blogMap.containsKey(currentPath)) {
      return;
    }
    final blogPost = File(markdown).readAsStringSync().split('\n');
    File(markdown).writeAsStringSync(
      blogPost.skip(1).reduce((value, element) => '$value\n$element'),
    );
    // ignore: avoid_print
    print('Publishing ${blogPost.first}...');
    blogMap[currentPath] = BlogManifest()
      ..idSuffix = '${blogMap.length}'
      ..name = blogPost.first
      ..path = currentPath
      ..uploadDate = DateTime.now();
  });

  final list = blogMap.values.toList()
    ..sort((a, b) => b.uploadDate.compareTo(a.uploadDate));

  manifestFile
      .writeAsStringSync(json.encode(list.map((e) => e.toMap()).toList()));
  // ignore: avoid_print
  print('Done!');
}

void actOnMarkdownFiles(
    String directoryPath, void Function(String path) action) {
  final directory = Directory(directoryPath);
  if (!directory.existsSync()) {
    // ignore: avoid_print
    print('Directory not found: $directoryPath');
    return;
  }

  final markdownFiles = directory
      .listSync(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('.md'))
      .toList();

  markdownFiles.forEach((file) {
    final filePath = file.path.replaceAll('\\', '/');
    action(filePath);
  });
}
