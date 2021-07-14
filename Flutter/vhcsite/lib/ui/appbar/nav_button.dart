import 'package:flutter/material.dart';
import 'package:vhcsite/model/navigation/navigation_bloc.dart';
import 'package:vhcsite/widget/default_button.dart';
import 'package:event_bloc/event_bloc.dart';
import 'package:provider/provider.dart';

class NavButton extends StatelessWidget {
  final String text;
  final String type;

  const NavButton({Key? key, required this.text, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BlocNotifier<NavigationBloc>>().bloc;
    return DefaultButton(
        text: text, type: type, disabled: type == model.navigationPath);
  }
}
