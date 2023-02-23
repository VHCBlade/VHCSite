import 'package:event_bloc/event_bloc.dart';

abstract class TextRepository extends Repository {
  Future<String> loadText(List<String> path);
}
