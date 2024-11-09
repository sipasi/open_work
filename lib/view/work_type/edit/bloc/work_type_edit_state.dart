part of 'work_type_edit_bloc.dart';

enum WorkTypeStorageStatus { none, deleteOrSubmit }

final class WorkTypeEditState {
  final String name;
  final String price;
  final CalculationType calculation;

  final WorkTypeStorageStatus storageStatus;

  const WorkTypeEditState({
    required this.name,
    required this.price,
    required this.calculation,
    required this.storageStatus,
  });

  const WorkTypeEditState.empty()
      : this(
          name: '',
          price: '',
          calculation: CalculationType.itemsCount,
          storageStatus: WorkTypeStorageStatus.none,
        );

  WorkTypeEditState copyWith({
    String? name,
    String? price,
    CalculationType? calculation,
    WorkTypeStorageStatus? storageStatus,
  }) {
    return WorkTypeEditState(
      name: name ?? this.name,
      price: price ?? this.price,
      calculation: calculation ?? this.calculation,
      storageStatus: storageStatus ?? this.storageStatus,
    );
  }
}
