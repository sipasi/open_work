import 'package:flutter_test/flutter_test.dart';
import 'package:open_work_flutter/data/calculations/work_calculator.dart';
import 'package:open_work_flutter/data/models/calculation_type.dart';
import 'package:open_work_flutter/data/models/work.dart';
import 'package:open_work_flutter/data/models/work_type.dart';
import 'package:open_work_flutter/data/models/work_unit.dart';

void main() {
  const WorkType numbersType = WorkType(
    name: 'numbers',
    calculation: CalculationType.numbersSum,
    price: 10.1,
  );
  const WorkType itemsType = WorkType(
    name: 'items',
    calculation: CalculationType.itemsCount,
    price: 10.1,
  );

  group('WorkCalculator Tests', () {
    test('WorkCalculator.one with CalculationType.numbersSum', () {
      final work = Work(
        numbersType,
        List.generate(10, (index) => WorkUnit('2')),
      );
      final sum = WorkCalculator.one(work);

      expect(sum, equals(202));
    });

    test('WorkCalculator.one with CalculationType.itemsCount', () {
      final work = Work(
        itemsType,
        List.generate(10, (index) => WorkUnit('2')),
      );
      final sum = WorkCalculator.one(work);

      expect(sum, equals(101));
    });

    test('WorkCalculator.many with CalculationType.numbersSum', () {
      final works = List.generate(
        10,
        (_) => Work(
          numbersType,
          List.generate(10, (index) => WorkUnit('2')),
        ),
      );
      final sum = WorkCalculator.many(works);

      expect(sum, equals(2020));
    });

    test('WorkCalculator.many with CalculationType.itemsCount', () {
      final works = List.generate(
        10,
        (_) => Work(
          itemsType,
          List.generate(10, (index) => WorkUnit('2')),
        ),
      );
      final sum = WorkCalculator.many(works);

      expect(sum, equals(1010));
    });
  });
}
