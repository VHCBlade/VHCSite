import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/services.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';

class DefaultTextRepository extends TextRepository {
  /// Loads all text files from the given path.
  @override
  Future<String> loadText(List<String> path) async {
    assert(path.isNotEmpty);

    final fullPath = path.reduce((a, b) => "$a/$b");
    final mdFile = "$fullPath.md";

    return await rootBundle.loadString(mdFile);
  }

  @override
  List<BlocEventListener> generateListeners(BlocEventChannel channel) => [];
}

class DelayedDefaultTextRepository extends TextRepository {
  final DefaultTextRepository defaultRepository = DefaultTextRepository();

  @override
  Future<String> loadText(List<String> path) async {
    await Future.delayed(const Duration(seconds: 1));
    return await defaultRepository.loadText(path);
  }

  @override
  List<BlocEventListener> generateListeners(BlocEventChannel channel) => [];
}
