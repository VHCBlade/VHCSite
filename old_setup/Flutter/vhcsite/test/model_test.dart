import 'package:event_db_tester/event_db_tester.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuple/tuple.dart';
import 'package:vhcsite/model/blog.dart';

void main() {
  group('Models', () {
    group('copy', () {
      genericModelTest(models: modelTestCases);
    });
    group('BlogManifest', () {
      test('category', () {
        final manifest1 = BlogManifest()..path = 'Stupendous/Incredible/Insane';
        final manifest2 = BlogManifest()..path = 'amazing/great/cool';

        expect(manifest1.category, 'Incredible');
        expect(manifest2.category, 'great');
        expect(manifest1.convertedPath, ['Stupendous', 'Incredible', 'Insane']);
        expect(manifest2.convertedPath, ['amazing', 'great', 'cool']);
      });
    });
  });
}

final modelTestCases = {
  'BlogManifest': () => Tuple2(
        BlogManifest()
          ..name = 'This is my Blog!'
          ..path = 'This/is/my/name'
          ..uploadDate = DateTime(1990),
        BlogManifest.new,
      ),
};
