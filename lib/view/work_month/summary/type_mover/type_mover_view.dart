import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/summaries/summary_model.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/view/work_month/summary/type_mover/bloc/type_mover_bloc.dart';
import 'package:open_work_flutter/view/work_month/summary/type_mover/widgets/work_type_list_dialog.dart';

class TypeMoverPage extends StatelessWidget {
  final int monthId;

  final WorkInfo info;
  final UnitDaysPairs pairs;
  final List<WorkType> supportedTypes;

  const TypeMoverPage({
    super.key,
    required this.monthId,
    required this.info,
    required this.pairs,
    required this.supportedTypes,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TypeMoverBloc(
        monthId: monthId,
        moveFrom: info.type,
        pairs: pairs,
        supportedToMove: supportedTypes,
        monthStorage: GetIt.I.get(),
      ),
      child: TypeMoverView(),
    );
  }
}

class TypeMoverView extends StatelessWidget {
  static final DateFormat _dayFormat = DateFormat(DateFormat.DAY);

  const TypeMoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TypeMoverBloc, TypeMoverState>(
      listener: (context, state) {
        if (state.moved) {
          MaterialNavigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.unit.value),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('current type'),
                  subtitle: Text(state.moveFrom.name),
                ),
                ListTile(
                  title: Text('move to type'),
                  subtitle: Text(state.moveTo.name),
                  onTap: () => _moveToHandler(context, state),
                ),
                _list(state, context),
              ],
            ),
          ),
          floatingActionButton: _fab(state, context),
        );
      },
    );
  }

  Widget _list(TypeMoverState state, BuildContext context) {
    return Column(
      children: List.generate(
        growable: false,
        state.dates.length,
        (index) {
          final wrapper = state.dates[index];

          bool contains = state.moveDates.contains(wrapper);

          return CheckboxListTile(
            title: Text(_dayFormat.format(wrapper.date)),
            value: contains,
            selected: contains,
            onChanged: (value) => _bloc(context).add(
              TypeMoverDateSelected(wrapper),
            ),
          );
        },
      ),
    );
  }

  FloatingActionButton? _fab(TypeMoverState state, BuildContext context) {
    return state.moveDates.isEmpty
        ? null
        : FloatingActionButton.extended(
            label: Text('Move'),
            onPressed: () {
              _bloc(context).add(
                TypeMoverMovePressed(),
              );
            },
          );
  }

  Future _moveToHandler(BuildContext context, TypeMoverState state) async {
    if (state.supportedToMove.isEmpty) {
      return;
    }

    final type = await WorkTypeListDialog.show(
      context: context,
      types: state.supportedToMove,
      current: state.moveTo,
    );

    if (type == null || type == state.moveTo) {
      return;
    }

    if (context.mounted) {
      _bloc(context).add(
        TypeMoverMoveToTypeChanged(type),
      );
    }
  }

  TypeMoverBloc _bloc(BuildContext context) => context.read();
}
