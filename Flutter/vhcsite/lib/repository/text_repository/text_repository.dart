import 'package:event_bloc/event_bloc.dart';

abstract class TextRepository extends Repository {
  Future<Map<String, String>> loadTextRepository(List<String> path);
}
