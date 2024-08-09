import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/theme_extension.dart';

class DayEditDropZone extends StatelessWidget {
  final void Function() onTapped;

  final Radius radius;
  final double? height;

  const DayEditDropZone({
    super.key,
    required this.onTapped,
    this.radius = const Radius.circular(8),
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = context.colorScheme.primary;
    final TextStyle? style = context.textTheme.bodyMedium?.copyWith(
      color: primary,
      fontWeight: FontWeight.bold,
    );

    return InkWell(
      onTap: onTapped,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: radius,
        color: primary,
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              'Tap or Drop here',
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
