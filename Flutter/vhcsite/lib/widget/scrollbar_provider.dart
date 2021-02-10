import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/state/event_channel.dart';

class ScrollbarProvider extends StatefulWidget {
  final Widget Function(ScrollController controller, BuildContext context)
      builder;
  final bool isAlwaysShown;
  final double? thickness;

  const ScrollbarProvider(
      {Key? key,
      required this.builder,
      this.isAlwaysShown = false,
      this.thickness})
      : super(key: key);

  @override
  _ScrollbarProviderState createState() => _ScrollbarProviderState();
}

class _ScrollbarProviderState extends State<ScrollbarProvider> {
  late final ScrollController controller;
  late final ProviderEventChannel channel;

  bool _updating = false;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    /// Assume that there will always be a Provider Event Channel, probably fix
    /// this later.
    channel = ProviderEventChannel(context.read<ProviderEventChannel>());
    channel.addEventListener(UPDATE_SCROLL, (_) {
      if (!_updating) {
        _updating = true;
        // This forces the controller to update.
        Future.delayed(Duration()).then((_) {
          if (!isDisposed) {
            controller.position.didUpdateScrollPositionBy(-0.1);
            _updating = false;
          }
        });
      }

      // Always absorb the event.
      return true;
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
    controller.dispose();
    channel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
        value: channel,
        child: Scrollbar(
            isAlwaysShown: widget.isAlwaysShown,
            controller: controller,
            thickness: widget.thickness,
            hoverThickness: widget.thickness,
            child: widget.builder(controller, context)));
  }
}
