import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.convertedPath});
  final List<String> convertedPath;

  Color colorCoordinate(BuildContext context, String category) {
    switch (category) {
      case 'life':
        return Colors.deepOrange;
      case 'flutter':
        return Colors.blue;
      case 'games':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorCoordinate(context, convertedPath[1]),
      padding: const EdgeInsets.all(5),
      child: Text(convertedPath[1].toUpperCase()),
    );
  }
}
