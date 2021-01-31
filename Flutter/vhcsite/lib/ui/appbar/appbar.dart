import 'package:flutter/material.dart';
import 'package:vhcsite/ui/appbar/nav_button.dart';
import 'package:vhcsite/widget/textscale.dart';

createAppBar(BuildContext context) => wrapInNoTextScale(
    AppBar(
        title: Image.asset('assets/img/LogoWithName.png', height: 56),
        actions: [
          NavButton(text: "Home", type: "home"),
          NavButton(text: "Flutter", type: "flutter"),
          NavButton(text: "YouTube", type: "youtube"),
          Container(width: 10)
        ]),
    context);
