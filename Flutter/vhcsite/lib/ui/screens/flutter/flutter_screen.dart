import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/page_text_model.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:vhcsite/ui/page/essay_layout.dart';
import 'package:vhcsite/ui/page/essay_text.dart';
import 'package:vhcsite/widget/scrollbar_provider.dart';

const _PATH = ['assets', 'text', 'dev', 'flutter', 'state'];
const _IMAGE_PATH = 'assets/img/dev/flutter/state';

class FlutterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelProvider(
        builder: (context, channel) {
          final repo = context.read<TextRepository>();
          final model = PageTextModel(
              parentChannel: channel, repository: repo, path: _PATH);

          model.eventChannel.fireEvent(TEXT_FILES_EVENT, '');
          return model;
        },
        child: ScrollbarProvider(
            isAlwaysShown: true,
            builder: (controller, _) => SingleChildScrollView(
                controller: controller,
                child: EssayLayout(
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
        EssayHeaderText(text: "I Love Flutter"),
        EssayLinkText(text: 'Flutter', link: 'https://flutter.dev'),
        EssayParagraphText(text: model.safeGetValue('love')),
        // State
        EssayHeaderText(text: "State of Ruin"),
        EssayParagraphText(text: model.safeGetValue('state')),
        // Provider
        EssayHeaderText(text: "Lean on Your Provider"),
        EssayLinkText(
            text: 'Provider', link: 'https://pub.dev/packages/provider'),
        EssayParagraphText(text: model.safeGetValue('provider')),
        EssayLinkText(
            text: 'Google I/O Provider Talk',
            link: 'https://www.youtube.com/watch?v=d_m5csmrf7I'),
        // Build
        EssayHeaderText(text: "Building on Provider"),
        EssayParagraphText(text: model.safeGetValue('build')),
        Image.asset('$_IMAGE_PATH/model.png'),
        Image.asset('$_IMAGE_PATH/notifier.png'),
        Image.asset('$_IMAGE_PATH/event.png'),
        EssayParagraphText(text: model.safeGetValue('solution')),
        // Example
        EssayHeaderText(text: "Lead by Example"),
        Image.asset('$_IMAGE_PATH/example.png'),
        EssayParagraphText(text: model.safeGetValue('example')),
        EssayLinkText(
            text: 'Link to Source Code',
            link: 'https://github.com/VHCBlade/VHCSite/tree/state-example'),
      ],
    );
  }
}
