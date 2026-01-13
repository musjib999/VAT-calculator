import 'package:equatable/equatable.dart';

class VatItem extends Equatable {
  final String id;
  final String name;
  final double price;

  const VatItem({
    required this.id,
    required this.name,
    required this.price,
  });

  VatItem copyWith({
    String? id,
    String? name,
    double? price,
  }) {
    return VatItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object> get props => [id, name, price];
}

