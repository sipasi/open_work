part of 'home_cubit.dart';

enum HomeTab { types, months, settings }

final class HomeState {
  final HomeTab tab;

  HomeState({required this.tab});
}
