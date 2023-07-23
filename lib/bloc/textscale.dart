import 'package:event_bloc/event_bloc.dart';
import 'package:event_db/event_db.dart';
import 'package:tuple/tuple.dart';

class TextScaleBloc extends Bloc {
  TextScaleBloc({required super.parentChannel});
}

class TextScaleModel extends GenericModel {
  double textScale = 1;

  @override
  Map<String, Tuple2<Getter, Setter>> getGetterSetterMap() => {};

  @override
  String get type => 'TextScale';
}
