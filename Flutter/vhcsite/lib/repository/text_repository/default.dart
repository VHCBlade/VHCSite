import 'dart:convert';

import 'package:event_bloc/src/event_bloc/event_channel.dart';
import 'package:flutter/services.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';

class DefaultTextRepository extends TextRepository {
  Map<String, dynamic>? assets;

  /// Loads all text files from the given path.
  Future<Map<String, String>> loadTextRepository(List<String> path) async {
    assert(path.isNotEmpty);

    if (assets == null) {
      assets = json.decode(await rootBundle.loadString('AssetManifest.json'));
    }

    // Retrieve all assets in the given path.
    final fullPath = path.reduce((a, b) => a + "/" + b);

    final retVal = <String, String>{};

    final list = await Future.wait(assets!.keys
        .where((element) => element.startsWith(fullPath))
        .where((element) => element.endsWith('.txt'))
        .map<Future<List>>((element) {
      final fileName =
          element.substring(fullPath.length + 1, element.length - 4);

      return rootBundle.loadString(element).then((value) => [fileName, value]);
    }));

    list.forEach((element) => retVal[element[0]] = element[1]);

    return retVal;
  }

  @override
  List<BlocEventListener> generateListeners(BlocEventChannel channel) => [];
}

class DelayedDefaultTextRepository extends TextRepository {
  final DefaultTextRepository defaultRepository = DefaultTextRepository();

  @override
  Future<Map<String, String>> loadTextRepository(List<String> path) async {
    await Future.delayed(Duration(seconds: 1));
    return await defaultRepository.loadTextRepository(path);
  }

  @override
  List<BlocEventListener> generateListeners(BlocEventChannel channel) => [];
}
