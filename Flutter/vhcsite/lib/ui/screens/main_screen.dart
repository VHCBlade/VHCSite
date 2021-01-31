import 'package:flutter/material.dart';
import 'package:vhcsite/widget/textscale.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wrapInNoTextScale(
          AppBar(
              title: Image.asset('img/LogoWithName.png', height: 56),
              actions: [
                FlatButton(
                  child: Text("Home"),
                  onPressed: () => null,
                ),
                FlatButton(
                  child: Text("Home"),
                  onPressed: () => null,
                ),
                Container(width: 10)
              ]),
          context),
    );
  }
}
