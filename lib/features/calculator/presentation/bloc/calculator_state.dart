import 'package:equatable/equatable.dart';
import '../../domain/entities/vat_calculation.dart';
import '../../domain/entities/vat_item.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {
  const CalculatorInitial();
}

class CalculatorLoading extends CalculatorState {
  const CalculatorLoading();
}

class CalculatorLoaded extends CalculatorState {
  final double amount;
  final double vatRate;
  final String formattedAmount;
  final String formattedVatRate;
  final bool isAmountValid;
  final List<VatItem> items;
  final double subtotal;
  final String formattedSubtotal;
  final VatCalculation? calculation;

  const CalculatorLoaded({
    required this.amount,
    required this.vatRate,
    required this.formattedAmount,
    required this.formattedVatRate,
    required this.isAmountValid,
    required this.items,
    required this.subtotal,
    required this.formattedSubtotal,
    this.calculation,
  });

  CalculatorLoaded copyWith({
    double? amount,
    double? vatRate,
    String? formattedAmount,
    String? formattedVatRate,
    bool? isAmountValid,
    List<VatItem>? items,
    double? subtotal,
    String? formattedSubtotal,
    VatCalculation? calculation,
  }) {
    return CalculatorLoaded(
      amount: amount ?? this.amount,
      vatRate: vatRate ?? this.vatRate,
      formattedAmount: formattedAmount ?? this.formattedAmount,
      formattedVatRate: formattedVatRate ?? this.formattedVatRate,
      isAmountValid: isAmountValid ?? this.isAmountValid,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      formattedSubtotal: formattedSubtotal ?? this.formattedSubtotal,
      calculation: calculation ?? this.calculation,
    );
  }

  @override
  List<Object> get props => [
        amount,
        vatRate,
        formattedAmount,
        formattedVatRate,
        isAmountValid,
        items,
        subtotal,
        formattedSubtotal,
        if (calculation != null) calculation!,
      ];
}

class CalculatorError extends CalculatorState {
  final String message;

  const CalculatorError(this.message);

  @override
  List<Object> get props => [message];
}

