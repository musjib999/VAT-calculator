import '../../domain/entities/vat_calculation.dart';
import '../../domain/entities/vat_item.dart';

class VatCalculationModel extends VatCalculation {
  const VatCalculationModel({
    required super.amount,
    required super.vatRate,
    required super.vatAmount,
    required super.totalAmount,
    required super.items,
  });

  factory VatCalculationModel.fromCalculation({
    required double amount,
    required double vatRate,
    required List<VatItem> items,
  }) {
    final vatAmount = amount * (vatRate / 100);
    final totalAmount = amount + vatAmount;

    return VatCalculationModel(
      amount: amount,
      vatRate: vatRate,
      vatAmount: vatAmount,
      totalAmount: totalAmount,
      items: items,
    );
  }

  factory VatCalculationModel.fromMap(Map<String, dynamic> map) {
    return VatCalculationModel(
      amount: map['amount']?.toDouble() ?? 0.0,
      vatRate: map['vatRate']?.toDouble() ?? 0.0,
      vatAmount: map['vatAmount']?.toDouble() ?? 0.0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      items: const [],
    );
  }
}

