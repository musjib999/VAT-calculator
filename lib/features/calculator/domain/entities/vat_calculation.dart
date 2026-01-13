import 'package:equatable/equatable.dart';
import 'vat_item.dart';

class VatCalculation extends Equatable {
  final double amount;
  final double vatRate;
  final double vatAmount;
  final double totalAmount;
  final List<VatItem> items;

  const VatCalculation({
    required this.amount,
    required this.vatRate,
    required this.vatAmount,
    required this.totalAmount,
    this.items = const [],
  });

  @override
  List<Object> get props => [amount, vatRate, vatAmount, totalAmount, items];

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'vatRate': vatRate,
      'vatAmount': vatAmount,
      'totalAmount': totalAmount,
      'items': items.map((item) => {
            'id': item.id,
            'name': item.name,
            'price': item.price,
          }).toList(),
    };
  }
}

