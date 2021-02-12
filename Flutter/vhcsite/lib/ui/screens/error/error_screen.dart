import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Could not find the page you are looking for.',
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Theme.of(context).primaryColor)));
  }
}
