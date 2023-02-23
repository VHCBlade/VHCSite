import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:vhcsite/events/events.dart';
import 'package:vhcsite/bloc/page_text.dart';
import 'package:vhcsite/repository/text_repository/text_repository.dart';
import 'package:provider/provider.dart';
import 'package:vhcsite/widget/scrollbar_provider.dart';

import 'essay_text.dart';

const ASSETS_IMG_PATH = 'assets/img/';
const ASSETS_TEXT_PATH = ['assets', 'text'];

class EssayLayout extends StatelessWidget {
  final Widget child;

  /// Correctly layouts the child inside a SignleChildScrollView for an Essay.
  const EssayLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
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
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: const EdgeInsets.all(30),
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
        final textPath = <String>[...ASSETS_TEXT_PATH, ...path];
        final repo = context.read<TextRepository>();
        final bloc = PageTextBloc(
            parentChannel: channel, repository: repo, path: textPath);

        bloc.eventChannel.fireEvent<void>(DataEvent.textFiles.event, null);

        bloc.blocUpdated.add(() => bloc.eventChannel
            .fireEvent<void>(UIEvent.updateScroll.event, null));
        return bloc;
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
    final bloc = context.watch<BlocNotifier<PageTextBloc>>().bloc;

    if (!bloc.loaded) {
      return const CircularProgressIndicator();
    }

    if (bloc.value.isEmpty) {
      return const EssayTitleText(text: "Ooops!!! Failed to load this page!");
    }

    return LoadedEssayContent(
      value: bloc.value,
      leading: leading,
      trailing: trailing,
    );
  }
}

class LoadedEssayContent extends StatelessWidget {
  final String value;
  final List<Widget> leading;
  final List<Widget> trailing;

  const LoadedEssayContent({
    super.key,
    required this.value,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final page = <Widget>[];

    page.addAll(leading);
    page.add(Markdown(
      selectable: true,
      data: value,
      onTapLink: (text, href, title) =>
          context.fireEvent<String>(UIEvent.url.event, href!),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          a: Theme.of(context).textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).primaryColor)),
    ));
    page.addAll(trailing);

    return Wrap(runSpacing: 10, spacing: 10, children: page);
  }
}
