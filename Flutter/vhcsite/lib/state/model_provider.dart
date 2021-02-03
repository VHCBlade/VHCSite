import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

class ModelNotifier<T extends Model> with ChangeNotifier {
  final T model;

  ModelNotifier(this.model) {
    model.modelUpdated.add(notifyListeners);
  }
}

class ModelProvider<T extends Model> extends StatefulWidget {
  final Widget child;
  final T Function(BuildContext, ProviderEventChannel?) builder;

  const ModelProvider({Key? key, required this.child, required this.builder})
      : super(key: key);

  @override
  _ModelProviderState<T> createState() => _ModelProviderState<T>();
}

class _ModelProviderState<T extends Model> extends State<ModelProvider<T>> {
  late final T model;

  @override
  void initState() {
    super.initState();
    ProviderEventChannel? eventChannel;
    try {
      eventChannel = context.read<ProviderEventChannel>();
    } on Object {
      // If something goes wrong, just set it to null.
      eventChannel = null;
    }

    model = widget.builder(context, eventChannel);
  }

  @override
  void dispose() {
    super.dispose();
    model.eventChannel.dispose();
    model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: model.eventChannel),
        ChangeNotifierProvider<ModelNotifier<T>>(
            create: (_) => ModelNotifier<T>(model)),
      ],
      child: widget.child,
    );
  }
}
