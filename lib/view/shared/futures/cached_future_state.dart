import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/futures/future_state.dart';

abstract class CachedFutureState<T extends StatefulWidget, TData>
    extends FutureState<T> {
  TData? _cache;

  TData? get cache => _cache;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TData>(
      future: future as Future<TData>,
      builder: (context, AsyncSnapshot<TData> snapshot) {
        if (snapshot.hasError) {
          error(context, snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading(context);
        }

        _cache = snapshot.data;

        return success(context, snapshot.data as TData);
      },
    );
  }

  @override
  Future<TData> getFuture();

  @protected
  Widget success(BuildContext context, TData data);
}
