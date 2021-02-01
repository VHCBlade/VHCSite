/// Event Listener, return value is true if the event is to be stopped from propagating
typedef bool ProviderEventListener(dynamic);

class ProviderEventChannel {
  final ProviderEventChannel _parentChannel;
  final Map<String, List<ProviderEventListener>> _listeners = {};

  ProviderEventChannel([this._parentChannel]);

  /// Fires and event that is sent up the event channel, stopping only
  /// when it reaches the top or an event stops the propagation.
  void fireEvent(String eventType, dynamic payload) {
    final shouldStopPropagation = _listenForEvent(eventType, payload);

    if (_parentChannel != null && !shouldStopPropagation) {
      _parentChannel.fireEvent(eventType, payload);
    }
  }

  /// Adds a listener for the specific event type.
  void addEventListener(String eventType, ProviderEventListener listener) {
    List<ProviderEventListener> potListeners = _listeners[eventType];

    if (potListeners == null) {
      potListeners = [];
      _listeners[eventType] = potListeners;
    }

    potListeners.add(listener);
  }

  /// Listens for the event, will return whether the event should be
  /// propagated up the channel or not.
  bool _listenForEvent(String eventType, dynamic payload) {
    List<ProviderEventListener> potListeners = _listeners[eventType];

    if (potListeners == null || potListeners.isEmpty) {
      return false;
    }

    return potListeners
        .map((listener) => listener(payload))
        .reduce((a, b) => a || b);
  }

  void dispose() {
    _listeners.clear();
  }
}
