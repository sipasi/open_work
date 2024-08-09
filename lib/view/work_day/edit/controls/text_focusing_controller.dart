import 'package:flutter/material.dart';

class TextFocusingController {
  final FocusNode node = FocusNode();

  void requestFocus() => node.requestFocus();
  void dispose() => node.dispose();
}
