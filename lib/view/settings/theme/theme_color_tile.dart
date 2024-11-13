import 'package:flutter/material.dart';
import 'package:open_work_flutter/theme/color/color_seed.dart';

class ThemeColorTile extends StatelessWidget {
  final ColorSeed seed;
  final void Function() onTap;

  const ThemeColorTile({
    super.key,
    required this.seed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Color'),
      subtitle: Text(seed.name),
      trailing: Icon(
        Icons.color_lens,
        color: seed.color,
      ),
      onTap: onTap,
    );
  }
}
