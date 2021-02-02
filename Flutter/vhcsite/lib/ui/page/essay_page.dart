import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/page_text_model.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/widget/scrollbar_provider.dart';

import 'essay_text.dart';

const ASSETS_IMG_PATH = 'assets/img';
const ASSETS_TEXT_PATH = ['assets', 'text'];

const _IMAGE_PATH = 'assets/img/dev/flutter/state';

class EssayLayout extends StatelessWidget {
  final child;

  /// Correctly layouts the child inside a SignleChildScrollView for an Essay.
  const EssayLayout({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        constraints: BoxConstraints(minWidth: double.infinity),
      ),
      Align(alignment: Alignment.topCenter, child: child)
    ]);
  }
}

class EssayScreen extends StatelessWidget {
  final List<String> path;

  /// Builds the essay screen with the [path] used to take the files from assets.
  const EssayScreen({Key key, @required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModelProvider(
        builder: (context, channel) {
          final textPath = <String>[]..addAll(ASSETS_TEXT_PATH)..addAll(path);
          final repo = context.read<TextRepository>();
          final model = PageTextModel(
              parentChannel: channel, repository: repo, path: textPath);

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
                  child: EssayContent(
                      path:
                          "$ASSETS_IMG_PATH${path.reduce((a, b) => '$a/$b')}"),
                )))));
  }
}

class EssayContent extends StatelessWidget {
  final String path;

  /// The Actual Content of the essay
  const EssayContent({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelNotifier<PageTextModel>>().model;

    if (!model.loaded) {
      return Center(child: CircularProgressIndicator());
    }

    final manifest = model.safeGetValue('manifest');

    if (manifest == null) {
      return EssayHeaderText(text: "Ooops!!! Failed to load this page!");
    }

    return LoadedEssayContent(manifest: manifest, model: model);
  }
}

class LoadedEssayContent extends StatefulWidget {
  final String manifest;
  final PageTextModel model;

  /// The content of the essay once the assets have been loaded.
  const LoadedEssayContent({Key key, this.manifest, this.model})
      : super(key: key);

  @override
  _LoadedEssayContentState createState() => _LoadedEssayContentState();
}

class _LoadedEssayContentState extends State<LoadedEssayContent> {
  List<List<String>> essayParts;

  @override
  void initState() {
    super.initState();
    essayParts =
        widget.manifest.split("\r\n").map((a) => a.split("\\")).toList();
  }

  /// Build Essay part, the first argument says what kind of part is.
  Widget _buildEssayPart(List<String> part) {
    switch (part[0]) {
      case 'paragraph':
        return EssayParagraphText(text: widget.model.safeGetValue(part[1]));
      case 'header':
        return EssayHeaderText(text: part[1]);
      case 'link':
        return EssayLinkText(text: part[1], link: part[2]);
      case 'image':
        return Image.asset('$_IMAGE_PATH/${part[1]}');
      default:
        return EssayHeaderText(text: "Failed to Load...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 10, children: essayParts.map(_buildEssayPart).toList());
  }
}
