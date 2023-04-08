import 'package:event_bloc/event_bloc.dart';
import 'package:event_db/event_db.dart';
import 'package:tuple/tuple.dart';

class BlogModel extends GenericModel {
  late String category;
  late String title;
  late DateTime postedOn;
  late String name;

  @override
  Map<String, Tuple2<Getter, Setter>> getGetterSetterMap() => {
        // TODO BP-29: Implement These
      };

  @override
  String get type => "Blog";
}

class BlogBloc extends Bloc {
  var blogMap = <String, Map<String, BlogModel>>{};

  BlogBloc({required super.parentChannel});
}
