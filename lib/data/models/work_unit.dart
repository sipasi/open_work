class WorkUnit {
  final String value;

  WorkUnit(this.value);

  @override
  bool operator ==(Object other) {
    return other is WorkUnit && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
