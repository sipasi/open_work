import 'package:flutter/material.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/view/shared/tiles/stretched_tile.dart';

class WorkTypeTile extends StatelessWidget {
  final WorkType type;

  final VoidCallback onTap;

  const WorkTypeTile({
    super.key,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheem = theme.colorScheme;

    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      color: scheem.primary,
    );
    final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
      color: Colors.green[400],
    );

    return Card.outlined(
      child: StretchedTile(
        title: Text(type.name, style: titleStyle),
        subtitle: Text(type.price.toString(), style: subtitleStyle),
        onTap: onTap,
      ),
    );
  }
}
