import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/widget/scrollbar_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollbarProvider(
        isAlwaysShown: true,
        builder: (controller, _) => Center(
            child: SingleChildScrollView(
                controller: controller,
                child: Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: double.infinity),
                    ),
                    Center(child: _HomeContent())
                  ],
                ))));
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 600),
      child: Column(children: [
        SelectableText(
          "Welcome to my Website!",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        Image.asset('assets/img/Logo.png'),
        Align(
            alignment: Alignment.centerRight,
            child: SelectableText(
              "Powered by Flutter",
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.right,
            )),
      ]),
    );
  }
}
