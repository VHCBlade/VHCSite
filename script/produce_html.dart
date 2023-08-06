import 'dart:convert';
import 'dart:io';

import 'package:vhcsite_models/vhcsite_models.dart';

/// Need to install python and run pip3 install md-to-html
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

    final blogPost = File(markdown).readAsStringSync();
    final manifest = blogMap[currentPath]!;

    final withTitle = '# ${manifest.name}\n\n$blogPost';
    final pathAsFilename = currentPath.replaceAll('/', '-');

    final file = File('assets/text/md/$pathAsFilename.md');
    file.writeAsStringSync(withTitle);

    // ignore: avoid_print
    print('Creating assets/text/html/$pathAsFilename.html');

    Process.run(
      'md-to-html',
      [
        '--input',
        'assets/text/md/$pathAsFilename.md',
        '--output',
        'assets/text/html/$pathAsFilename.html'
      ],
    );
  });

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
