import 'package:flutter/material.dart';
import 'package:vhcsite/ui/theme/colors.dart';
import 'package:vhcsite/ui/theme/material_state.dart';

ThemeData createTheme() {
  final themeData = ThemeData(
    primaryColor: PRIMARY_COLOR,
    canvasColor: SECONDARY_COLOR,
    disabledColor: DISABLED_COLOR,
    cardColor: SECONDARY_COLOR,
    highlightColor: HIGHLIGHT_COLOR,
    appBarTheme: AppBarTheme(color: PRIMARY_COLOR),
    scrollbarTheme: ScrollbarThemeData(
        thumbColor:
            ScrollbarMaterialStateColor(HIGHLIGHT_COLOR, PRIMARY_COLOR)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: textButtonBackgroundColor,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)))),
        overlayColor: textButtonOverlayColor,
        surfaceTintColor: MaterialStateProperty.all(HIGHLIGHT_COLOR),
      ),
    ),
  );

  return themeData.copyWith(
      textTheme: themeData.textTheme
          .apply(bodyColor: TEXT_COLOR, displayColor: TEXT_COLOR));
}

MaterialStateProperty<Color> get textButtonBackgroundColor =>
    MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return DISABLED_COLOR;
      }
      if (states.contains(MaterialState.hovered) &&
          !states.contains(MaterialState.disabled)) {
        return HIGHLIGHT_COLOR.withAlpha(99);
      }
      return Colors.transparent;
    });

MaterialStateProperty<Color?> get textButtonOverlayColor =>
    MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return HIGHLIGHT_COLOR.withAlpha(99);
      }
      if (states.contains(MaterialState.disabled)) {
        return HIGHLIGHT_COLOR.withAlpha(1);
      }

      return Colors.transparent;
    });
