import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_work_flutter/services/navigation/material_navigator.dart';
import 'package:open_work_flutter/view/shared/input_fields/price_edit_field.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_field.dart';
import 'package:open_work_flutter/view/shared/layouts/separated_column.dart';
import 'package:open_work_flutter/view/work_type/edit/bloc/work_type_edit_bloc.dart';
import 'package:open_work_flutter/view/work_type/edit/widgets/calculation_segmented_button.dart';

class TypeEditView extends StatelessWidget {
  final int? id;

  final TextEditController nameEdit;
  final TextEditController priceEdit;

  const TypeEditView({
    super.key,
    required this.id,
    required this.nameEdit,
    required this.priceEdit,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WorkTypeEditBloc>();

    return Padding(
      padding: const EdgeInsets.all(20).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<WorkTypeEditBloc, WorkTypeEditState>(
            listenWhen: (previous, current) => _isEmptyChanged(
              previous.name,
              current.name,
            ),
            listener: (context, state) {
              nameEdit.setErrorIfEmpty();
            },
          ),
          BlocListener<WorkTypeEditBloc, WorkTypeEditState>(
            listenWhen: (previous, current) => _isEmptyChanged(
              previous.price,
              current.price,
            ),
            listener: (context, state) {
              priceEdit.setErrorIfEmpty();
            },
          ),
          BlocListener<WorkTypeEditBloc, WorkTypeEditState>(
            listenWhen: (previous, current) =>
                current.storageStatus == WorkTypeStorageStatus.deleteOrSubmit,
            listener: (context, state) {
              MaterialNavigator.pop(context);
            },
          ),
        ],
        child: SeparatedColumn(
          separator: (context, index) => const SizedBox(height: 10),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: id != null,
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    onPressed: () => bloc.add(
                      WorkTypeEditDeleteRequested(id),
                    ),
                  ),
                ),
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.save),
                  label: Text(id == null ? 'Create' : 'Edit'),
                  onPressed: () => bloc.add(
                    WorkTypeEditSubmitRequested(id),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlocBuilder<WorkTypeEditBloc, WorkTypeEditState>(
              buildWhen: (previous, current) => _isEmptyChanged(
                previous.name,
                current.name,
              ),
              builder: (context, state) {
                return TextEditField(
                  label: 'name',
                  controller: nameEdit,
                  border: const OutlineInputBorder(),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => bloc.add(
                    WorkTypeEditNameChanged(value),
                  ),
                );
              },
            ),
            BlocBuilder<WorkTypeEditBloc, WorkTypeEditState>(
              buildWhen: (previous, current) => _isEmptyChanged(
                previous.price,
                current.price,
              ),
              builder: (context, state) {
                return PriceEditField(
                  label: 'price',
                  style: TextStyle(color: Colors.green),
                  controller: priceEdit,
                  border: const OutlineInputBorder(),
                  onChanged: (value) => bloc.add(
                    WorkTypeEditPriceChanged(value),
                  ),
                );
              },
            ),
            const SizedBox(),
            BlocBuilder<WorkTypeEditBloc, WorkTypeEditState>(
              buildWhen: (previous, current) =>
                  previous.calculation != current.calculation,
              builder: (context, state) {
                return CalculationSegmentedButton(
                  selected: state.calculation,
                  onSelected: (value) => bloc.add(
                    WorkTypeEditCalculationChanged(value),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static bool _isEmptyChanged(String previous, String current) {
    return previous.isEmpty == current.isNotEmpty;
  }
}
