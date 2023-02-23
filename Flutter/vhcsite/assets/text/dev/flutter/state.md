# I Love Flutter

[Flutter](https://flutter.dev) is awesome! It's remarkably easy to learn, since all of the code is in a single modern language (Google's Dart). No more dealing with Markup Languages that require copy pasting a lot of code or cryptic CSS Files. Of course the greatest selling point of Flutter is that it can be deployed pretty much anywhere while reusing all your code. 

Flutter does all of this while maintaining a consistent beauty with lightning fast rendering times. It started with iOS and Android and now you can deploy Flutter anywhere. Even on a website, just like this one!

# State of Ruin

Of course, everything has a tradeoff. Whenever you go into a new technology there is a greater chance of running into problems that don't have solutions yet. This becomes less of a concern as Flutter continues to mature, however there is one pitfall that can make using Flutter incredibly difficult. STATE MANAGEMENT. 

Choosing a cumbersome one can lead to productivity drains that just suck away all the fun of using Flutter. I've lost so many nights of sleep thinking about the right way to handle State Management. But thankfully, we can learn from our mistakes, as well as the mistakes of others.

# Lean on Your Provider

[Provider](https://pub.dev/packages/provider) to the rescue! Provider gives us a way to avoid this trap. If you aren't yet familiar with Provider, I suggest clicking on the link to their package site and reading the documentation and example. You can also easily find some resources about Provider made by other people with just a quick Google Search. [Some even come from the Google Team!](https://www.youtube.com/watch?v=d_m5csmrf7I) 

Combining related information to form one state under a ChangeNotifier strikes the perfect balance between individual states and developer usability. Provider gives us a good baseline from which our state management solution can spring.

# Building on Provider

While Provider is good, there are some things about it that I take issue with. 

First, ChangeNotifier, the class suggested to hold our Model, has a dependency on the Flutter Framework! While this isn't a big issue, it just feels disgusting. This is also makes it impossible to have our model be purely dart code.

Second, there isn't a canonical way to have a ChangeNotifier that relies on a Parent ChangeNotifier get an update from the Parent. This can lead to some confusion within large teams about what the right way to update children is. 

Third, it requires our buttons and other low level UI to have a dependency on the Model. This leads to a lot boilerplate code being repeated and makes it more difficult to make changes to our code.

Luckily, Provider is powerful enough that we can easily fix this with a few lines of code.

```dart
abstract class Model {
  List<void Function()> modelUpdated = [];
  ProviderEventChannel get eventChannel;
  void updateModel() => modelUpdated.forEach((element) => element());
}
```

```dart
class ModelNotifier<T extends Model> with ChangeNotifier {
  final T model;

  ModelNotifier(this.model) {
    model.modelUpdated.add(notifyListeners);
  }
}

class ModelProvider<T extends Model> extends StatefulWidget {
  final Widget child;
  final T Function(BuildContext, ProviderEventChannel) builder;

  const ModelProvider({Key key, @required this.child, @required this.builder})
      : super(key: key);

  @override
  _ModelProviderState<T> createState() => _ModelProviderState<T>();
}
```

```dart
typedef bool ProviderEventListener(dynamic);

class ProviderEventChannel {
  final ProviderEventChannel _parentChannel;
  final Map<String, List<ProviderEventListener>> _listeners = {};

  ProviderEventChannel([this._parentChannel]);

  void fireEvent(String eventType, dynamic payload) {
    // ...
  }

  void addEventListener(String eventType, ProviderEventListener listener) {
    // ...
  }
}
```

Don't worry about the missing source code. There's a link to the github page for this website at the bottom of this page.

First we have our Model Class. As the name suggests this will be our new model, and all of our Models will extend this Class. This model slots into the ModelNotifier, which extends the original model, ChangeNotifier. Calling updateModel on our model will automatically call notifyListeners. Now we no longer need to have our model depend on the Flutter Framework!

Second, our Model class also comes with a List of functions to call in modelUpdated. Child Models can simply subscribe to the model updating of their parents with a specific action to take. Just make sure you unsubscribe when the Child Model is disposed! (Probably should have added a dispose function to Model. I actually already have, just not in this version. Whoops!)

Third, instead of having UI elements call methods in the model directly, we'll have them fire events up the nearest event channel instead. [Get the closest EventChannel with Provider.of<ProviderEventChannel>() or context.watch<ProviderEventChannel>()]. 

Now we can do cool things like have our buttons only require a type parameter, and the model will simply listen for events. Hooray! This also has the added benefit of creating a canonical event channel that can be used to propagate any information from the leaves of our widget tree all the way to the root!

# Lead by Example

```dart
import 'package:vhcsite/state/model.dart';
import 'package:vhcsite/state/event_channel.dart';

const _POSSIBLE_NAVIGATIONS = {"home", "flutter"};

class NavigationModel with Model {
  final ProviderEventChannel eventChannel;
  String navigationPath = "flutter";

  NavigationModel({ProviderEventChannel parentChannel})
      : eventChannel = ProviderEventChannel(parentChannel) {
    eventChannel.addEventListener("button", (payload) {
      navigate(payload);
      return false;
    });
  }

  void navigate(String navigate) {
    if (!_POSSIBLE_NAVIGATIONS.contains(navigate)) {
      return;
    }

    if (navigationPath == navigate) {
      return;
    }

    navigationPath = navigate;
    updateModel();
  }
}
```

Well the first thing you'll notice is the use of the event channel. We listen for a button event and simply match it with our possible navigations. The button doesn't even know that it's actually being used for navigation. That also means that if we want to change the functionality of the button, we don't even have to look at the buttons!

You'll also see how little the model cares about the UI. That being, it doesn't care at all. It simply changes the current navigation value and lets anyone who cares know that the navigation value has changed. In this case, I simply change the underlying body. It's not the best form of navigation in the world, but hey, it's all I need right now.

Then I just feed it into my ModelProvider and voila, I have Navigation enabled!

I hope that this has given you a good idea on how to handle state management in Flutter. Do what you're good at and have a great day!

[Link to Source Code](https://github.com/VHCBlade/VHCSite/tree/state-example/Flutter/vhcsite/lib/state)