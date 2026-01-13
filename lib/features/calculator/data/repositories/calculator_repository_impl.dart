import '../../domain/entities/vat_calculation.dart';
import '../../domain/entities/vat_item.dart';
import '../../domain/repositories/calculator_repository.dart';
import '../models/vat_calculation_model.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  @override
  Future<VatCalculation> calculateVat({
    required double amount,
    required double vatRate,
    required List<VatItem> items,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    return VatCalculationModel.fromCalculation(
      amount: amount,
      vatRate: vatRate,
      items: items,
    );
  }
}

