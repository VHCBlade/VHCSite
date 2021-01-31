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
        HeaderText(text: "I Love Flutter"),
        SelectableText.rich(createLinkTextSpan(
          'Flutter',
          'https://flutter.dev',
          context,
          [createTextSpan(model.safeGetValue('love'), context)],
        )),
        HeaderText(text: "State of Ruin"),
        SelectableText(
          model.safeGetValue('state'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        HeaderText(text: "Lean on Your Provider"),
        SelectableText.rich(createLinkTextSpan(
          'Provider',
          'https://pub.dev/packages/provider',
          context,
          [
            createTextSpan(model.safeGetValue('provider'), context),
            createTextSpan("\n", context),
            createLinkTextSpan('Google I/O Provider Talk',
                'https://www.youtube.com/watch?v=d_m5csmrf7I', context)
          ],
        )),
        HeaderText(text: "Building on Provider"),
        SelectableText(
          model.safeGetValue('build'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Image.asset(_IMAGE_PATH + 'model.png'),
        Image.asset(_IMAGE_PATH + 'notifier.png'),
        Image.asset(_IMAGE_PATH + 'event.png'),
        SelectableText(
          model.safeGetValue('solution'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        HeaderText(text: "Lead by Example"),
        Image.asset(_IMAGE_PATH + 'example.png'),
        SelectableText(
          model.safeGetValue('example'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SelectableText.rich(createLinkTextSpan(
          'Link to Source Code',
          'https://github.com/VHCBlade/VHCSite/tree/state-example',
          context,
        )),
      ],
    );
  }
}
