import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

class ModelProvider<T extends Model> extends StatefulWidget {
  final Widget child;
  final T Function(BuildContext, EventChannel) builder;

  const ModelProvider({Key key, @required this.child, @required this.builder})
      : super(key: key);

  @override
  _ModelProviderState<T> createState() => _ModelProviderState<T>();
}

class ModelNotifier<T extends Model> with ChangeNotifier {
  final T model;

  ModelNotifier(this.model) {
    model.modelUpdated = notifyListeners;
  }
}

class _ModelProviderState<T extends Model> extends State<ModelProvider<T>> {
  T model;

  @override
  void initState() {
    super.initState();
    EventChannel eventChannel;
    try {
      eventChannel = Provider.of<EventChannel>(context, listen: false);
    } on dynamic {
      // If something goes wrong, just set it to null.
      eventChannel = null;
    }

    model = widget.builder(context, eventChannel);
    if (model == null) {
      throw Exception("Did not create a Model in Model Provider!");
    }
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
