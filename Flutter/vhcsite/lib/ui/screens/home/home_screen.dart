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
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Column(children: [
                    SelectableText(
                      "Welcome to my Website!",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    Image.asset('img/Logo.png'),
                    Align(
                        alignment: Alignment.centerRight,
                        child: SelectableText(
                          "Powered by Flutter",
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.right,
                        )),
                  ]),
                ),
              ),
            ));
  }
}
