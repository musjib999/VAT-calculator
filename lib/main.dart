import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';


import 'core/utils/utils.dart';
import 'shared/themes/app_theme.dart';
import 'features/calculator/presentation/view/screens/calculator_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
      title: 'VAT Calculator',
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: const CalculatorScreen(),
      ),
    );
  }
}
