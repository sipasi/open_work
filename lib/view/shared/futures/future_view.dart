import 'dart:async';

import 'package:flutter/material.dart';

class FutureView<T> extends StatelessWidget {
  final Future<T> future;

  final Widget Function(BuildContext context)? loading;
  final Widget Function(BuildContext context, Object? error)? error;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      success;

  const FutureView({
    super.key,
    required this.future,
    this.loading,
    this.error,
    required this.success,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return error?.call(context, snapshot.error) ??
              Text(snapshot.error?.toString() ?? 'Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading?.call(context) ?? const LinearProgressIndicator();
        }

        return success(context, snapshot);
      },
    );
  }
}
