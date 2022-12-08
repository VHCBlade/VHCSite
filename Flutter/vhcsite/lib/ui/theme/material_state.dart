import 'package:flutter/material.dart';

class ScrollbarMaterialStateColor extends MaterialStateColor {
  final Color base;
  final Color dragged;

  ScrollbarMaterialStateColor(this.base, this.dragged) : super(base.value);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.dragged)) {
      return dragged;
    }
    return base;
  }
}
