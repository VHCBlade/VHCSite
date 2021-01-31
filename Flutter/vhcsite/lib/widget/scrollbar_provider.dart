import 'package:flutter/material.dart';

class ScrollbarProvider extends StatefulWidget {
  final Widget Function(ScrollController controller, BuildContext context)
      builder;
  final bool isAlwaysShown;
  final double thickness;

  const ScrollbarProvider(
      {Key key, this.builder, this.isAlwaysShown, this.thickness})
      : super(key: key);

  @override
  _ScrollbarProviderState createState() => _ScrollbarProviderState();
}

class _ScrollbarProviderState extends State<ScrollbarProvider> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        isAlwaysShown: widget.isAlwaysShown,
        controller: controller,
        thickness: widget.thickness,
        child: widget.builder(controller, context));
  }
}
