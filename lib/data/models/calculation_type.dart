enum CalculationType {
  /// Calculate the sum of all numbers.
  numbersSum,

  /// Calculate the sum based on the count of items.
  itemsCount;

  bool isNumbers() => this == CalculationType.numbersSum;
  bool isItems() => this == CalculationType.itemsCount;
}
