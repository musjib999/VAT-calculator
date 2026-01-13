import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vat_calculator/core/utils/formatters.dart';
import 'package:vat_calculator/shared/components/app_input_field.dart';
import 'package:vat_calculator/features/calculator/domain/entities/vat_item.dart';

class VatItemRow extends StatefulWidget {
  final VatItem item;
  final ValueChanged<VatItem> onItemChanged;
  final VoidCallback onRemove;

  const VatItemRow({
    super.key,
    required this.item,
    required this.onItemChanged,
    required this.onRemove,
  });

  @override
  State<VatItemRow> createState() => _VatItemRowState();
}

class _VatItemRowState extends State<VatItemRow> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _priceController = TextEditingController(
      text: widget.item.price > 0 
          ? VatFormatters.formatCurrency(widget.item.price)
          : '',
    );
  }

  @override
  void didUpdateWidget(VatItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.price != widget.item.price && widget.item.price > 0) {
      _priceController.text = VatFormatters.formatCurrency(widget.item.price);
    }
    if (oldWidget.item.name != widget.item.name) {
      _nameController.text = widget.item.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Item name input
        Expanded(
          flex: 2,
          child: AppInputField(
            controller: _nameController,
            hintText: 'Item name',
            onChanged: (value) {
              widget.onItemChanged(
                widget.item.copyWith(name: value),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        // Currency symbol
        Text(
          '₦',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 4),
        // Price input
        Expanded(
          flex: 1,
          child: AppInputField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              ThousandsSeparatorInputFormatter(),
            ],
            hintText: '0',
            onChanged: (value) {
              if (value.isEmpty) {
                widget.onItemChanged(
                  widget.item.copyWith(price: 0.0),
                );
                return;
              }
              try {
                final parsed = VatFormatters.parseFormattedNumber(value);
                widget.onItemChanged(
                  widget.item.copyWith(price: parsed),
                );
              } catch (e) {
                // Invalid input
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        // Remove button
        GestureDetector(
          onTap: widget.onRemove,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.close,
              color: Colors.red,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

