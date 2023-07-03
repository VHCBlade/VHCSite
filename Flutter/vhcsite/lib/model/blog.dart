import 'package:event_db/event_db.dart';
import 'package:tuple/tuple.dart';

class BlogManifest extends GenericModel {
  late String path;
  late String name;
  late DateTime uploadDate;

  List<String> get convertedPath => path.split('/');
  String get category => convertedPath[1];

  @override
  Map<String, Tuple2<Getter, Setter>> getGetterSetterMap() => {
        'path': GenericModel.primitive(
            () => path, (value) => path = value as String),
        'name': GenericModel.primitive(
            () => name, (value) => name = value as String),
        'uploadDate': GenericModel.dateTime(
            () => uploadDate, (value) => uploadDate = value!),
      };

  @override
  String get type => 'BlogManifest';
}
