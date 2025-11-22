// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vhcblade_theme/vhcblade_theme.dart';

ThemeData createSiteTheme() {
  final theme = createTheme();
  return theme.copyWith(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: textButtonBackgroundColor,
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)))),
          overlayColor: textButtonOverlayColor,
          surfaceTintColor: WidgetStateProperty.all(HIGHLIGHT_COLOR),
          foregroundColor:
              WidgetStateProperty.all(theme.textTheme.bodyLarge!.color)),
    ),
  );
}

WidgetStateProperty<Color> get textButtonBackgroundColor =>
    WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const Color(0x80000000);
      }
      if (states.contains(WidgetState.hovered) &&
          !states.contains(WidgetState.disabled)) {
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
