import 'package:flutter/cupertino.dart';

class EssayLayout extends StatelessWidget {
  final child;

  /// Correctly layouts the child inside a SignleChildScrollView for an Essay.
  const EssayLayout({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        constraints: BoxConstraints(minWidth: double.infinity),
      ),
      Align(alignment: Alignment.topCenter, child: child)
    ]);
  }
}
