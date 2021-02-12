import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/model/page_text_model.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:vhcsite/state/model_provider.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/widget/scrollbar_provider.dart';

import 'essay_text.dart';

const ASSETS_IMG_PATH = 'assets/img/';
const ASSETS_TEXT_PATH = ['assets', 'text'];

class EssayLayout extends StatelessWidget {
  final child;

  /// Correctly layouts the child inside a SignleChildScrollView for an Essay.
  const EssayLayout({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        constraints: BoxConstraints(minWidth: double.infinity),
      ),
      Center(child: child)
    ]);
  }
}

class EssayScreen extends StatelessWidget {
  final List<String> path;
  final List<Widget> trailing;

  /// Builds the essay screen with the [path] used to take the files from assets.
  ///
  /// [trailing] is placed in a row after the content loaded in the manifest.
  const EssayScreen({Key? key, required this.path, this.trailing = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollbarProvider(
      isAlwaysShown: true,
      builder: (controller, _) => ModelProvider(
        create: (context, channel) {
          final textPath = <String>[]..addAll(ASSETS_TEXT_PATH)..addAll(path);
          final repo = context.read<TextRepository>();
          final model = PageTextModel(
              parentChannel: channel, repository: repo, path: textPath);

          model.eventChannel.fireEvent(TEXT_FILES_EVENT, '');

          // Do this to update the controller.
          model.modelUpdated
              .add(() => model.eventChannel.fireEvent(UPDATE_SCROLL, ''));
          return model;
        },
        child: Center(
          child: SingleChildScrollView(
            controller: controller,
            child: EssayLayout(
              child: Container(
                constraints: BoxConstraints(maxWidth: 1200),
                padding: EdgeInsets.all(30),
                child: EssayContent(
                    imagePath:
                        "$ASSETS_IMG_PATH${path.reduce((a, b) => '$a/$b')}",
                    trailing: trailing),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EssayContent extends StatelessWidget {
  final String imagePath;
  final List<Widget> trailing;

  /// The Actual Content of the essay
  const EssayContent(
      {Key? key, required this.imagePath, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelNotifier<PageTextModel>>().model;

    if (!model.loaded) {
      return CircularProgressIndicator();
    }

    final manifest = model.values['manifest'];

    if (manifest == null) {
      return EssayHeaderText(text: "Ooops!!! Failed to load this page!");
    }

    return LoadedEssayContent(
        imagePath: imagePath,
        manifest: manifest,
        model: model,
        trailing: trailing);
  }
}

class LoadedEssayContent extends StatefulWidget {
  final String manifest;
  final List<Widget> trailing;
  final PageTextModel model;
  final String imagePath;

  /// The content of the essay once the assets have been loaded.
  const LoadedEssayContent(
      {Key? key,
      required this.manifest,
      required this.model,
      required this.trailing,
      required this.imagePath})
      : super(key: key);

  @override
  _LoadedEssayContentState createState() => _LoadedEssayContentState();
}

class _LoadedEssayContentState extends State<LoadedEssayContent> {
  late final List<List<String>> essayParts;

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
      case 'title':
        return EssayTitleText(text: part[1]);
      case 'header':
        return EssayHeaderText(text: part[1]);
      case 'link':
        return EssayLinkText(text: part[1], link: part[2]);
      case 'image':
        return InteractiveViewer(
            child: Image.asset('${widget.imagePath}/${part[1]}'));
      default:
        return EssayHeaderText(text: "Failed to Load...");
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = essayParts.map(_buildEssayPart).toList();
    page.addAll(widget.trailing);

    return Wrap(runSpacing: 10, children: page);
  }
}
