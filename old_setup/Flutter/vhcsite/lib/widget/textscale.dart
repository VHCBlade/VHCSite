import 'package:flutter/material.dart';

PreferredSizeWidget wrapInNoTextScale(
    PreferredSizeWidget widget, BuildContext context) {
  final query = MediaQuery.of(context);

  return PreferredSize(
      preferredSize: widget.preferredSize,
      child:
          MediaQuery(data: query.copyWith(textScaleFactor: 1), child: widget));
}
