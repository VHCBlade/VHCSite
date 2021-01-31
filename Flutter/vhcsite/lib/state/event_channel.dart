typedef bool EventListener(dynamic);

class EventChannel {
  final EventChannel _parentChannel;
  final Map<String, List<EventListener>> _listeners = {};

  EventChannel([this._parentChannel]);

  void fireEvent(String eventType, dynamic payload) {
    final shouldStopPropagation = _listenForEvent(eventType, payload);

    if (_parentChannel != null && !shouldStopPropagation) {
      _parentChannel.fireEvent(eventType, payload);
    }
  }

  void listenForEvent(String eventType, EventListener listener) {
    List<EventListener> potListeners = _listeners[eventType];

    if (potListeners == null) {
      potListeners = [];
      _listeners[eventType] = potListeners;
    }

    potListeners.add(listener);
  }

  /// Listens for the event, will return whether the event should be
  /// propagated up the channel or not.
  bool _listenForEvent(String eventType, dynamic payload) {
    List<EventListener> potListeners = _listeners[eventType];

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
