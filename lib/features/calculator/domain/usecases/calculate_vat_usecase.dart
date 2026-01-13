import '../entities/vat_calculation.dart';
import '../entities/vat_item.dart';
import '../repositories/calculator_repository.dart';

class CalculateVatUseCase {
  final CalculatorRepository repository;

  CalculateVatUseCase(this.repository);

  Future<VatCalculation> call({
    required double amount,
    required double vatRate,
    required List<VatItem> items,
  }) {
    return repository.calculateVat(
      amount: amount,
      vatRate: vatRate,
      items: items,
    );
  }
}

