import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/view/shared/input_fields/text_edit_controller.dart';
import 'package:open_work_flutter/view/work_type/edit/bloc/work_type_edit_bloc.dart';
import 'package:open_work_flutter/view/work_type/edit/widgets/type_edit_view.dart';

class TypeEditSheet {
  static Future create(BuildContext context) async {
    return _show(context);
  }

  static Future edit(BuildContext context, WorkType entity) async {
    return _show(context, entity);
  }

  static Future _show(BuildContext context, [WorkType? entity]) async {
    TextEditController nameEdit = TextEditController.text(
      text: entity?.name ?? '',
    );
    TextEditController priceEdit = TextEditController.text(
      text: entity?.price.toString() ?? '',
    );

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) => BlocProvider(
        create: (context) {
          return WorkTypeEditBloc(typeStorage: GetIt.I.get())
            ..add(WorkTypeEditInitRequested(entity));
        },
        child: TypeEditView(
          id: entity?.id,
          nameEdit: nameEdit,
          priceEdit: priceEdit,
        ),
      ),
    );
  }
}
