import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vat_calculator/features/calculator/domain/entities/vat_item.dart';
import 'package:vat_calculator/features/calculator/domain/usecases/calculate_vat_usecase.dart';
import '../../../../core/utils/formatters.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculateVatUseCase calculateVatUseCase;
  
  final TextEditingController amountController = TextEditingController();
  final TextEditingController vatRateController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();

  bool _isUpdatingFromSlider = false;

  static const double minAmount = 0.0;
  static const double maxAmount = 100000000.0;
  static const double minVatRate = 0.0;
  static const double maxVatRate = 30.0;
  static const double amountStep = 100000.0;
  static const double vatRateStep = 0.5;
  static const List<double> presetRates = [5, 7.5, 10, 15, 20];

  CalculatorBloc({
    required this.calculateVatUseCase,
  }) : super(const CalculatorInitial()) {
    on<InitializeCalculator>(_onInitializeCalculator);
    on<AmountChanged>(_onAmountChanged);
    on<AmountChangedFromText>(_onAmountChangedFromText);
    on<VatRateChanged>(_onVatRateChanged);
    on<VatRateChangedFromText>(_onVatRateChangedFromText);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<UpdateItemName>(_onUpdateItemName);
    on<UpdateItemPrice>(_onUpdateItemPrice);
    on<UpdateItemPriceFromText>(_onUpdateItemPriceFromText);
    on<CalculateVat>(_onCalculateVat);
  }

  void _onInitializeCalculator(
    InitializeCalculator event,
    Emitter<CalculatorState> emit,
  ) {
    const initialAmount = 0.0;
    const initialVatRate = 7.5;
    const initialItems = <VatItem>[];

    amountController.text = '';
    vatRateController.text = initialVatRate.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');

    emit(CalculatorLoaded(
      amount: initialAmount,
      vatRate: initialVatRate,
      formattedAmount: '',
      formattedVatRate: initialVatRate.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), ''),
      isAmountValid: false,
      items: initialItems,
      subtotal: 0.0,
      formattedSubtotal: VatFormatters.formatCurrency(0.0),
    ));
  }

  void _updateSubtotalAndAmount(Emitter<CalculatorState> emit, List<VatItem> items) {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      final subtotal = items.fold<double>(0.0, (sum, item) => sum + item.price);
      final formattedSubtotal = VatFormatters.formatCurrency(subtotal);
      final formattedAmount = subtotal > 0 ? formattedSubtotal : '';
      
      if (subtotal > 0) {
        amountController.text = formattedAmount;
      } else {
        amountController.text = '';
      }

      emit(currentState.copyWith(
        items: items,
        subtotal: subtotal,
        formattedSubtotal: formattedSubtotal,
        amount: subtotal,
        formattedAmount: formattedAmount,
        isAmountValid: subtotal > 0,
        calculation: null,
      ));
    }
  }

  void _onAddItem(
    AddItem event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      final newItem = VatItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: '',
        price: 0.0,
      );
      final updatedItems = [...currentState.items, newItem];
      _updateSubtotalAndAmount(emit, updatedItems);
    }
  }

  void _onRemoveItem(
    RemoveItem event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      final updatedItems = currentState.items
          .where((item) => item.id != event.itemId)
          .toList();
      _updateSubtotalAndAmount(emit, updatedItems);
    }
  }

  void _onUpdateItemName(
    UpdateItemName event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      final updatedItems = currentState.items.map((item) {
        if (item.id == event.itemId) {
          return item.copyWith(name: event.name);
        }
        return item;
      }).toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }

  void _onUpdateItemPrice(
    UpdateItemPrice event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      final updatedItems = currentState.items.map((item) {
        if (item.id == event.itemId) {
          return item.copyWith(price: event.price);
        }
        return item;
      }).toList();
      _updateSubtotalAndAmount(emit, updatedItems);
    }
  }

  void _onUpdateItemPriceFromText(
    UpdateItemPriceFromText event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      if (event.priceText.isEmpty) {
        add(UpdateItemPrice(event.itemId, 0.0));
        return;
      }

      try {
        final parsed = VatFormatters.parseFormattedNumber(event.priceText);
        add(UpdateItemPrice(event.itemId, parsed));
      } catch (e) {
        // Invalid input, keep previous value
      }
    }
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      final clampedAmount = event.amount.clamp(minAmount, maxAmount);
      
      if (currentState.amount != clampedAmount) {
        final formattedAmount = VatFormatters.formatCurrency(clampedAmount);
        
        _syncAmountController(clampedAmount, formattedAmount);
        
        emit(currentState.copyWith(
          amount: clampedAmount,
          formattedAmount: formattedAmount,
          isAmountValid: clampedAmount > 0,
          calculation: null,
        ));
      }
    }
  }

  void _onAmountChangedFromText(
    AmountChangedFromText event,
    Emitter<CalculatorState> emit,
  ) {
    if (_isUpdatingFromSlider) return;

    if (state is CalculatorLoaded) {
      if (event.amountText.isEmpty) {
        add(const AmountChanged(0));
        return;
      }

      try {
        final parsed = VatFormatters.parseFormattedNumber(event.amountText);
        add(AmountChanged(parsed));
      } catch (e) {
        rethrow;
      }
    }
  }

  void _onVatRateChanged(
    VatRateChanged event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      final clampedVatRate = event.vatRate.clamp(minVatRate, maxVatRate);
      
      if (currentState.vatRate != clampedVatRate) {
        final formattedVatRate = clampedVatRate.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
        
        _syncVatRateController(clampedVatRate, formattedVatRate);
        
        emit(currentState.copyWith(
          vatRate: clampedVatRate,
          formattedVatRate: formattedVatRate,
            calculation: null,
        ));
      }
    }
  }

  void _onVatRateChangedFromText(
    VatRateChangedFromText event,
    Emitter<CalculatorState> emit,
  ) {
    if (state is CalculatorLoaded) {
      if (event.vatRateText.isEmpty) {
        add(const VatRateChanged(0));
        return;
      }

      final parsed = double.tryParse(event.vatRateText) ?? 0;
      add(VatRateChanged(parsed));
    }
  }

  Future<void> _onCalculateVat(
    CalculateVat event,
    Emitter<CalculatorState> emit,
  ) async {
    if (state is CalculatorLoaded) {
      final currentState = state as CalculatorLoaded;
      
      if (currentState.amount <= 0) {
        emit(CalculatorError('Amount must be greater than 0'));
        return;
      }

      emit(currentState.copyWith());

      try {
        final calculation = await calculateVatUseCase(
          amount: currentState.amount,
          vatRate: currentState.vatRate,
          items: currentState.items,
        );

        emit(currentState.copyWith(calculation: calculation));
      } catch (e) {
        emit(CalculatorError('Failed to calculate VAT: ${e.toString()}'));
      }
    }
  }

  void _syncAmountController(double amount, String formattedAmount) {
    final currentText = amountController.text;
    final currentAmountValue = currentText.isEmpty
        ? 0
        : (VatFormatters.parseFormattedNumber(currentText).toInt());
    final controllerAmountValue = amount.toInt();

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

  void _syncVatRateController(double vatRate, String formattedVatRate) {
    final currentVatRateText = vatRateController.text;
    if (currentVatRateText != formattedVatRate &&
        double.tryParse(currentVatRateText) != vatRate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        vatRateController.text = formattedVatRate;
        vatRateController.selection = TextSelection.collapsed(
          offset: formattedVatRate.length,
        );
      });
    }
  }

  @override
  Future<void> close() {
    amountController.dispose();
    vatRateController.dispose();
    amountFocusNode.dispose();
    return super.close();
  }
}
