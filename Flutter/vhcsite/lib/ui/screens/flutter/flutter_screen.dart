import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/model/page_text_model.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:vhcsite/ui/page/essay_text.dart';
import 'package:vhcsite/widget/scrollbar_provider.dart';

const _PATH = ['assets', 'text', 'flutter', 'state'];
const _IMAGE_PATH = 'assets/img/flutter/state/';

class FlutterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelProvider(
        builder: (context, channel) {
          final repo = Provider.of<TextRepository>(context, listen: false);
          final model = PageTextModel(
              parentChannel: channel, repository: repo, path: _PATH);

          model.eventChannel.fireEvent('retrieve_text_files', '');
          return model;
        },
        child: ScrollbarProvider(
            isAlwaysShown: true,
            builder: (controller, _) => Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                    controller: controller,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 1200),
                      padding: EdgeInsets.all(30),
                      child: FlutterPageContent(),
                    )))));
  }
}

class FlutterPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelNotifier<PageTextModel>>().model;

    if (!model.loaded) {
      return Center(child: CircularProgressIndicator());
    }

    return Wrap(
      runSpacing: 10,
      children: [
        // Love
        HeaderText(text: "I Love Flutter"),
        createLinkText('Flutter', 'https://flutter.dev', context),
        createText(model.safeGetValue('love'), context),
        // State
        HeaderText(text: "State of Ruin"),
        Text(
          model.safeGetValue('state'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        // Provider
        HeaderText(text: "Lean on Your Provider"),
        createLinkText(
            'Provider', 'https://pub.dev/packages/provider', context),

        createText(model.safeGetValue('provider'), context),
        createLinkText('Google I/O Provider Talk',
            'https://www.youtube.com/watch?v=d_m5csmrf7I', context),
        // Build
        HeaderText(text: "Building on Provider"),
        createText(model.safeGetValue('build'), context),
        Image.asset(_IMAGE_PATH + 'model.png'),
        Image.asset(_IMAGE_PATH + 'notifier.png'),
        Image.asset(_IMAGE_PATH + 'event.png'),
        createText(model.safeGetValue('solution'), context),
        // Example
        HeaderText(text: "Lead by Example"),
        Image.asset(_IMAGE_PATH + 'example.png'),
        createText(model.safeGetValue('example'), context),
        createLinkText(
          'Link to Source Code',
          'https://github.com/VHCBlade/VHCSite/tree/state-example',
          context,
        ),
      ],
    );
  }
}
