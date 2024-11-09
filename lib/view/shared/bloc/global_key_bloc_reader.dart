import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension GlobalKeyBlocReader on GlobalKey? {
  T? read<T extends BlocBase>() {
    final mountedContext = this?.currentContext;

    if (mountedContext == null) {
      return null;
    }

    if (mountedContext.mounted == false) {
      return null;
    }

    final bloc = mountedContext.read<T>();

    return bloc.isClosed ? null : bloc;
  }
}

extension KeyBlocReader on Key? {
  T? read<T extends BlocBase>() {
    return (this as GlobalKey?).read();
  }
}
