import 'package:flutter/material.dart';

class ThemeModeTile extends StatelessWidget {
  final ThemeMode mode;
  final void Function(ThemeMode value) onChanged;

  const ThemeModeTile({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SegmentedButton(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: ThemeMode.dark,
            icon: Icon(Icons.dark_mode),
            label: Text('dark'),
          ),
          ButtonSegment(
            value: ThemeMode.light,
            icon: Icon(Icons.light_mode),
            label: Text('light'),
          ),
          ButtonSegment(
            value: ThemeMode.system,
            icon: Icon(Icons.devices),
            label: Text('system'),
          ),
        ],
        selected: {mode},
        onSelectionChanged: (set) => onChanged(set.first),
      ),
    );
  }
}
