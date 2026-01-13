import 'package:flutter/material.dart';
import '../../../core/utils/formatters.dart';

class CalculatorController extends ChangeNotifier {
  double _amount = 1000.0;
  double _vatRate = 10.0;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController vatRateController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();

  bool _isUpdatingFromSlider = false;
  static const List<double> presetRates = [5, 7.5, 10, 15, 20];

  double get amount => _amount;
  double get vatRate => _vatRate;
  bool get isAmountValid => _amount > 0;

  double get vatAmount => _amount * (_vatRate / 100);
  double get totalAmount => _amount + vatAmount;

  static const double minAmount = 0.0;
  static const double maxAmount = 100000000.0;
  static const double minVatRate = 0.0;
  static const double maxVatRate = 30.0;
  static const double amountStep = 100000.0;
  static const double vatRateStep = 0.5;

  CalculatorController() {
    _initializeControllers();
    _setupListeners();
  }

  void _initializeControllers() {
    amountController.text = VatFormatters.formatCurrency(_amount);
    vatRateController.text = _vatRate.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
  }

  void _setupListeners() {
    addListener(_syncTextControllers);
  }

  void _syncTextControllers() {
    if (_isUpdatingFromSlider) return;

    _syncAmountController();

    _syncVatRateController();
  }

  void _syncAmountController() {
    final formattedAmount = VatFormatters.formatCurrency(_amount);
    final currentText = amountController.text;
    final currentAmountValue = currentText.isEmpty
        ? 0
        : (VatFormatters.parseFormattedNumber(currentText).toInt());
    final controllerAmountValue = _amount.toInt();

    
    if (controllerAmountValue != currentAmountValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _isUpdatingFromSlider = true;
        amountController.text = formattedAmount;
        amountController.selection = TextSelection.collapsed(
          offset: formattedAmount.length,
        );
        Future.delayed(const Duration(milliseconds: 50), () {
          _isUpdatingFromSlider = false;
        });
      });
    }
  }

  void _syncVatRateController() {
    final vatRateText = _vatRate.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
    final currentVatRateText = vatRateController.text;
    if (currentVatRateText != vatRateText &&
        double.tryParse(currentVatRateText) != _vatRate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        vatRateController.text = vatRateText;
        vatRateController.selection = TextSelection.collapsed(
          offset: vatRateText.length,
        );
      });
    }
  }

  void setAmount(double value) {
    final clampedValue = value.clamp(minAmount, maxAmount);
    if (_amount != clampedValue) {
      _amount = clampedValue;
      notifyListeners();
    }
  }

  void setAmountFromText(String value) {
    if (_isUpdatingFromSlider) return;

    if (value.isEmpty) {
      setAmount(0);
      return;
    }

    try {
      final parsed = VatFormatters.parseFormattedNumber(value);
      setAmount(parsed);
    } catch (e) {
      rethrow;
    }
  }

  void setVatRate(double value) {
    final clampedValue = value.clamp(minVatRate, maxVatRate);
    if (_vatRate != clampedValue) {
      _vatRate = clampedValue;
      notifyListeners();
    }
  }

  void setVatRateFromText(String value) {
    if (value.isEmpty) {
      setVatRate(0);
      return;
    }

    final parsed = double.tryParse(value) ?? 0;
    setVatRate(parsed);
  }

  Map<String, dynamic> get calculationResult => {
        'amount': _amount,
        'vatRate': _vatRate,
        'vatAmount': vatAmount,
        'totalAmount': totalAmount,
      };

  @override
  void dispose() {
    amountController.dispose();
    vatRateController.dispose();
    amountFocusNode.dispose();
    super.dispose();
  }
}

