import '../entities/vat_calculation.dart';
import '../entities/vat_item.dart';

abstract class CalculatorRepository {
  Future<VatCalculation> calculateVat({
    required double amount,
    required double vatRate,
    required List<VatItem> items,
  });
}

