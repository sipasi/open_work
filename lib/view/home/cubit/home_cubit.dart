import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(tab: HomeTab.months));

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));
}
