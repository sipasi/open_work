import 'package:flutter/material.dart';
import 'package:open_work_flutter/view/shared/futures/future_state.dart';

abstract class WaitState<T extends StatefulWidget> extends FutureState<T> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          error(context, snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading(context);
        }

        return success(context);
      },
    );
  }

  @protected
  Widget success(BuildContext context);
}
