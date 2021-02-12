import 'package:flutter/material.dart';
import 'package:vhcsite/ui/theme/colors.dart';
import 'package:vhcsite/ui/theme/material_state.dart';

ThemeData createTheme() {
  final themeData = ThemeData(
      primaryColor: PRIMARY_COLOR,
      backgroundColor: SECONDARY_COLOR,
      canvasColor: SECONDARY_COLOR,
      disabledColor: DISABLED_COLOR,
      cardColor: SECONDARY_COLOR,
      highlightColor: HIGHLIGHT_COLOR,
      scrollbarTheme: ScrollbarThemeData(
          thumbColor:
              ScrollbarMaterialStateColor(HIGHLIGHT_COLOR, PRIMARY_COLOR)));

  return themeData.copyWith(
      textTheme: themeData.textTheme
          .apply(bodyColor: TEXT_COLOR, displayColor: TEXT_COLOR));
}
