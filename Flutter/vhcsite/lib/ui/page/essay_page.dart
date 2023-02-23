import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/bloc/page_text.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
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

class EssayScroll extends StatelessWidget {
  final Widget child;

  const EssayScroll({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollbarProvider(
      isAlwaysShown: true,
      builder: (controller, _) => Center(
        child: SingleChildScrollView(
          controller: controller,
          child: EssayLayout(
            child: Container(
                constraints: BoxConstraints(maxWidth: 1200),
                padding: EdgeInsets.all(30),
                child: child),
          ),
        ),
      ),
    );
  }
}

class EssayScreen extends StatelessWidget {
  final List<String> path;
  final List<Widget> leading;
  final List<Widget> trailing;

  /// Builds the essay screen with the [path] used to take the files from assets.
  ///
  /// [leading] is placed in a row before the content loaded in the manifest.
  /// [trailing] is placed in a row after the content loaded in the manifest.
  const EssayScreen(
      {Key? key,
      required this.path,
      this.trailing = const [],
      this.leading = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context, channel) {
        final textPath = <String>[]
          ..addAll(ASSETS_TEXT_PATH)
          ..addAll(path);
        final repo = context.read<TextRepository>();
        final model = PageTextBloc(
            parentChannel: channel, repository: repo, path: textPath);

        model.eventChannel.fireEvent<void>(DataEvent.textFiles.event, null);

        // Do this to update the controller.
        model.blocUpdated.add(() => model.eventChannel
            .fireEvent<void>(UIEvent.updateScroll.event, null));
        return model;
      },
      child: EssayScroll(
        child: EssayContent(
          imagePath: "$ASSETS_IMG_PATH${path.reduce((a, b) => '$a/$b')}",
          trailing: trailing,
          leading: leading,
        ),
      ),
    );
  }
}

class EssayContent extends StatelessWidget {
  final String imagePath;
  final List<Widget> trailing;
  final List<Widget> leading;

  /// The Actual Content of the essay
  const EssayContent(
      {Key? key,
      required this.imagePath,
      required this.trailing,
      required this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BlocNotifier<PageTextBloc>>().bloc;

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
        leading: leading,
        trailing: trailing);
  }
}

class LoadedEssayContent extends StatefulWidget {
  final String manifest;
  final List<Widget> leading;
  final List<Widget> trailing;
  final PageTextBloc model;
  final String imagePath;

  /// The content of the essay once the assets have been loaded.
  const LoadedEssayContent(
      {Key? key,
      required this.manifest,
      required this.model,
      required this.trailing,
      required this.leading,
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
        return EssayImage(imagePath: '${widget.imagePath}/${part[1]}');
      default:
        return EssayHeaderText(text: "Failed to Load...");
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = <Widget>[];

    page.addAll(widget.leading);
    page.addAll(essayParts.map(_buildEssayPart).toList());
    page.addAll(widget.trailing);

    return Wrap(runSpacing: 10, spacing: 10, children: page);
  }
}
