import 'package:flutter/material.dart';

abstract class FutureState<T extends StatefulWidget> extends State<T> {
  Future? _future;

  Future? get future => _future;

  @override
  void initState() {
    super.initState();

    onInitState();

    loadFuture();
  }

  @protected
  void onInitState() {}

  @protected
  Future getFuture();

  @protected
  void loadFuture() {
    _future = getFuture();
  }

  @protected
  Widget loading(BuildContext context) {
    return const CircularProgressIndicator();
  }

  @protected
  Widget error(BuildContext context, Object? error) =>
      Text('$runtimeType: has error: $error');
}
