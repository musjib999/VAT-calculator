import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class AmountChanged extends CalculatorEvent {
  final double amount;

  const AmountChanged(this.amount);

  @override
  List<Object> get props => [amount];
}

class AmountChangedFromText extends CalculatorEvent {
  final String amountText;

  const AmountChangedFromText(this.amountText);

  @override
  List<Object> get props => [amountText];
}

class VatRateChanged extends CalculatorEvent {
  final double vatRate;

  const VatRateChanged(this.vatRate);

  @override
  List<Object> get props => [vatRate];
}

class VatRateChangedFromText extends CalculatorEvent {
  final String vatRateText;

  const VatRateChangedFromText(this.vatRateText);

  @override
  List<Object> get props => [vatRateText];
}

class CalculateVat extends CalculatorEvent {
  const CalculateVat();
}

class InitializeCalculator extends CalculatorEvent {
  const InitializeCalculator();
}

class AddItem extends CalculatorEvent {
  const AddItem();
}

class RemoveItem extends CalculatorEvent {
  final String itemId;

  const RemoveItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class UpdateItemName extends CalculatorEvent {
  final String itemId;
  final String name;

  const UpdateItemName(this.itemId, this.name);

  @override
  List<Object> get props => [itemId, name];
}

class UpdateItemPrice extends CalculatorEvent {
  final String itemId;
  final double price;

  const UpdateItemPrice(this.itemId, this.price);

  @override
  List<Object> get props => [itemId, price];
}

class UpdateItemPriceFromText extends CalculatorEvent {
  final String itemId;
  final String priceText;

  const UpdateItemPriceFromText(this.itemId, this.priceText);

  @override
  List<Object> get props => [itemId, priceText];
}

