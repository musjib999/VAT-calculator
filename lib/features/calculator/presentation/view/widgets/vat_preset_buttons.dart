import 'package:flutter/material.dart';

class VatPresetButtons extends StatelessWidget {
  final List<double> presetRates;
  final double selectedRate;
  final ValueChanged<double> onRateSelected;

  const VatPresetButtons({
    super.key,
    required this.presetRates,
    required this.selectedRate,
    required this.onRateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: presetRates.map((rate) {
        final isSelected = rate == selectedRate;
        return GestureDetector(
          onTap: () => onRateSelected(rate),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF9333EA)
                  : const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF9333EA).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            transform: Matrix4.identity()
              ..scale(isSelected ? 1.05 : 1.0),
            child: Text(
              '$rate%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF9333EA),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

