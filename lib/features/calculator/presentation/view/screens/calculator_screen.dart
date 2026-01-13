import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vat_calculator/core/utils/locator.dart';
import 'package:vat_calculator/features/calculator/domain/usecases/calculate_vat_usecase.dart';
import 'package:vat_calculator/shared/components/app_input_field.dart';
import 'package:vat_calculator/shared/widgets/theme_switcher.dart';

import '../../bloc/bloc.dart';
import '../widgets/widgets.dart';
import 'result_screen.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleCalculate(BuildContext context, CalculatorBloc bloc) {
    final state = bloc.state;
    if (state is CalculatorLoaded && state.isAmountValid) {
      bloc.add(const CalculateVat());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: bloc,
            child: const ResultScreen(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CalculatorBloc(
          calculateVatUseCase: locator<CalculateVatUseCase>(),
        );
        bloc.add(const InitializeCalculator());
        return bloc;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 48), // Spacer for centering
                        const Expanded(
                          child: VatHeader(
                            title: 'VAT Calculator',
                            subtitle: 'Calculate your VAT quickly and easily',
                          ),
                        ),
                        const ThemeSwitcher(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: BlocBuilder<CalculatorBloc, CalculatorState>(
                        builder: (context, state) {
                          if (state is CalculatorLoaded) {
                            final bloc = context.read<CalculatorBloc>();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Items',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => bloc.add(const AddItem()),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF9333EA),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            const Text(
                                              'Add Item',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                if (state.items.isEmpty)
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                                          : const Color(0xFFF3E8FF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No items added. Tap "Add Item" to start.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  ...state.items.map((item) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: VatItemRow(
                                        item: item,
                                        onItemChanged: (updatedItem) {
                                          if (updatedItem.id.isNotEmpty) {
                                            bloc.add(UpdateItemName(
                                              updatedItem.id,
                                              updatedItem.name,
                                            ));
                                            bloc.add(UpdateItemPrice(
                                              updatedItem.id,
                                              updatedItem.price,
                                            ));
                                          }
                                        },
                                        onRemove: () {
                                          bloc.add(RemoveItem(item.id));
                                        },
                                      ),
                                    );
                                  }),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Subtotal',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      state.formattedSubtotal,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'VAT Rate',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: AppInputField(
                                        controller: bloc.vatRateController,
                                        keyboardType: const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}'),
                                          ),
                                        ],
                                        hintText: 'VAT Rate',
                                        onChanged: (value) {
                                          bloc.add(VatRateChangedFromText(value));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                VatSlider(
                                  value: state.vatRate,
                                  min: CalculatorBloc.minVatRate,
                                  max: CalculatorBloc.maxVatRate,
                                  step: CalculatorBloc.vatRateStep,
                                  onChanged: (value) {
                                    bloc.add(VatRateChanged(value));
                                  },
                                  minLabel: '0%',
                                  maxLabel: '30%',
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  'Quick Select',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                VatPresetButtons(
                                  presetRates: CalculatorBloc.presetRates,
                                  selectedRate: state.vatRate,
                                  onRateSelected: (value) {
                                    bloc.add(VatRateChanged(value));
                                  },
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<CalculatorBloc, CalculatorState>(
                      builder: (context, state) {
                        final isValid = state is CalculatorLoaded && state.isAmountValid;
                        final bloc = context.read<CalculatorBloc>();
                        
                        return GestureDetector(
                          onTap: isValid
                              ? () => _handleCalculate(context, bloc)
                              : null,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 56,
                            decoration: BoxDecoration(
                              color: isValid
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: isValid
                                  ? [
                                      BoxShadow(
                                        color: Theme.of(context).primaryColor
                                            .withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calculate,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Calculate VAT',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
