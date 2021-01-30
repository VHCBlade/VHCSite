import 'package:flutter/material.dart';

PreferredSizeWidget wrapInNoTextScale(
    PreferredSizeWidget widget, BuildContext context) {
  final query = MediaQuery.of(context);

  return PreferredSize(
      child:
          MediaQuery(data: query.copyWith(textScaleFactor: 1), child: widget),
      preferredSize: widget.preferredSize);
}
