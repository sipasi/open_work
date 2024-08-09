import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';

class SeparatedColumnSection extends StatelessWidget {
  final Widget title;

  final int length;

  final Widget Function(int index) builder;

  const SeparatedColumnSection({
    super.key,
    required this.title,
    required this.length,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Column(
        children: [
          ListTile(title: title),
          SeparatedColumn(
            separator: (context, index) => const Divider(height: 0),
            children: List.generate(length, builder),
          ),
        ],
      ),
    );
  }
}
