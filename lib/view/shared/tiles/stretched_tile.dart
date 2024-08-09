import 'package:flutter/material.dart';

class StretchedTile extends StatelessWidget {
  final Widget title;

  final Widget subtitle;

  final void Function() onTap;

  final EdgeInsetsGeometry margin;

  const StretchedTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.margin = const EdgeInsets.all(14.0),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            title,
            const Spacer(),
            subtitle,
          ],
        ),
      ),
    );
  }
}
