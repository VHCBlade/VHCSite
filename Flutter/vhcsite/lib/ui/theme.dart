import 'package:flutter/material.dart';
import 'package:vhcsite/ui/colors.dart';

ThemeData createTheme() {
  final themeData = ThemeData(
    primaryColor: PRIMARY_COLOR,
    backgroundColor: SECONDARY_COLOR,
    canvasColor: SECONDARY_COLOR,
  );

  themeData.textTheme.apply(bodyColor: TEXT_COLOR, displayColor: TEXT_COLOR);

  return themeData;
}
